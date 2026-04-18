import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, ParseIntPipe, Put } from '@nestjs/common';
import { ProductsService } from './products.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import {FileTypeValidationPipe} from 'src/utils/file-validator';
import { CategoryService } from 'src/category/category.service';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService, private readonly categoryService:CategoryService) {}

  @Post()
  @UseInterceptors(FileFieldsInterceptor([{name:"images",maxCount:3}]) as any,)
  create(
    @Body() createProductDto: CreateProductDto,
    @UploadedFiles() 
    // @UploadedFiles(new FileTypeValidationPipe()) USED FOR VALIDATING THE SINGLE FILES ASSUMPTION... 
    files:{images? : Express.Multer.File[]}
  ) {
    return this.productsService.create(createProductDto,files.images||[]);
  }

  @Get()
  findAllProducts() {
    return this.productsService.findAllProducts();
  }

  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.productsService.findOneProduct(+id);
  }

  @Get('category/:id')
  findProductsBasedOnCategory(@Param('id') id: number) {
    return this.productsService.findProductsBasedOnCategory(+id);
  }


  @Put(':id')
  @UseInterceptors(FileFieldsInterceptor([{name:"images",maxCount:3}])) 
  async updateProduct(
  @Param('id', ParseIntPipe) id: number,
  @Body() updateProductDto: UpdateProductDto,
  @UploadedFiles() files?: Express.Multer.File[],
) {
  return this.productsService.updateProduct(id, updateProductDto, files);
}

  @Delete()
  remove() {
    return this.productsService.remove();
  }
}
