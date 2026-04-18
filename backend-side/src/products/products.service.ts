import { HttpException, HttpStatus, Injectable, NotFoundException } from '@nestjs/common';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { MediaService } from 'src/media/media.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { Product } from 'prisma/@prisma/client';
import { CategoryService } from 'src/category/category.service';


@Injectable()
export class ProductsService {
   constructor(
    private readonly mediaService:MediaService,
    private prismaService:PrismaService,
    private readonly categoryService:CategoryService
  ){}
  // Create a product and uploads its images to cloudinary
  async create(
    createProductDto: CreateProductDto,
    files: Express.Multer.File[],
  ) {
    const uploadImages=await Promise.all(
      files.map((file:Express.Multer.File)=>this.mediaService.uploadImages(file))
    );

    const product= await this.prismaService.product.create({
      data:{
        name:createProductDto.name,
        price:createProductDto.price,
        description:createProductDto.description,
        stock:createProductDto.stock,
        categoryId:parseInt(String(createProductDto.categoryId)),
        ProductImage:{
          create:uploadImages.map((url)=>({
            url
          })),
        }
      },
      include:{ProductImage:{select:{url:true}}}
    });
    return product;
  }

  async findAllProducts():Promise<Product[]> {
    const products=await this.prismaService.product.findMany(
      {
        include:{
          ProductImage:{
            select:{
              url:true
            }
          }
        }
      });
      if(!products){
        throw new HttpException(`Product not found`,HttpStatus.NOT_FOUND);
      }
    return products;
  }

 async findOneProduct(id:number):Promise<Product> {
    const product=await this.prismaService.product.findUnique({
      include:{
          ProductImage:{
            select:{
              url:true
            }
          }
        },
      where:{id:id}
    });
      if(!product){
        throw new HttpException(`Product not found`,HttpStatus.NOT_FOUND);
      }
    return product;
  }

  async findProductsBasedOnCategory(id:number):Promise<Product[]> {
    const products=await this.prismaService.product.findMany({
      include:{
          ProductImage:{
            select:{
              url:true
            }
          }
        },
      where:{categoryId:id}
    });
      if(!products){
        throw new HttpException(`Product not found`,HttpStatus.NOT_FOUND);
      }
    return products;
  }
  async updateProduct(
  productId: number,
  updateProductDto: UpdateProductDto,
  files?: Express.Multer.File[],
) {
  // First, verify that the product exists and get current images
  const existingProduct = await this.prismaService.product.findUnique({
    where: { id: productId },
    include: { ProductImage: true }
  });

  if (!existingProduct) {
    throw new NotFoundException(`Product with ID ${productId} not found`);
  }

  // If categoryId is provided, verify it exists
  if (updateProductDto.categoryId) {
    const categoryExists = await this.prismaService.category.findUnique({
      where: { id: updateProductDto.categoryId }
    });

    if (!categoryExists) {
      throw new NotFoundException(`Category with ID ${updateProductDto.categoryId} not found`);
    }
  }

  // Handle image updates if new files are provided
  let imageUpdateOperations = {};
  
  if (files && files.length > 0) {
    // Delete old images from Cloudinary
    if (existingProduct.ProductImage.length > 0) {
      await Promise.all(
        existingProduct.ProductImage.map(image => 
          this.mediaService.deleteImage(image.url) // Assuming you have a delete method
        )
      );
    }

    // Upload new images to Cloudinary
    const uploadImages = await Promise.all(
      files.map((file: Express.Multer.File) => 
        this.mediaService.uploadImages(file)
      )
    );

    // Prepare image update operations
    imageUpdateOperations = {
      ProductImage: {
        deleteMany: {}, // Delete all existing images for this product
        create: uploadImages.map((url) => ({
          url
        }))
      }
    };
  }

  // Update the product
  const updatedProduct = await this.prismaService.product.update({
    where: { id: productId },
    data: {
      ...(updateProductDto.name && { name: updateProductDto.name }),
      ...(updateProductDto.price && { price: updateProductDto.price }),
      ...(updateProductDto.description && { description: updateProductDto.description }),
      ...(updateProductDto.stock && { stock: updateProductDto.stock }),
      ...(updateProductDto.categoryId && { categoryId: updateProductDto.categoryId }),
      ...imageUpdateOperations
    },
    include: {
      ProductImage: { select: { url: true } },
      category: { select: { id: true, name: true } }
    }
  });

  return updatedProduct;
}

// Alternative version if you want to update only images
async updateProductImages(
  productId: number,
  files: Express.Multer.File[],
) {
  // Verify product exists
  const existingProduct = await this.prismaService.product.findUnique({
    where: { id: productId },
    include: { ProductImage: true }
  });

  if (!existingProduct) {
    throw new NotFoundException(`Product with ID ${productId} not found`);
  }

  // Delete old images from Cloudinary
  if (existingProduct.ProductImage.length > 0) {
    await Promise.all(
      existingProduct.ProductImage.map(image => 
        this.mediaService.deleteImage(image.url) // Assuming you have a delete method
      )
    );
  }

  // Upload new images
  const uploadImages = await Promise.all(
    files.map((file: Express.Multer.File) => 
      this.mediaService.uploadImages(file)
    )
  );

  // Update product with new images
  const updatedProduct = await this.prismaService.product.update({
    where: { id: productId },
    data: {
      ProductImage: {
        deleteMany: {}, // Delete all existing images
        create: uploadImages.map((url) => ({
          url
        }))
      }
    },
    include: {
      ProductImage: { select: { url: true } }
    }
  });

  return updatedProduct;
}

  remove() {
   return this.prismaService.product.deleteMany();
  }
}
