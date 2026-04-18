import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { Category } from "prisma/@prisma/client";


@Injectable()
export class CategoryService {
  constructor(private prismaService:PrismaService){}

  async create(createCategoryDto: CreateCategoryDto) {
    const category=await this.prismaService.category.create(
      {
        data:createCategoryDto
      });
    if(!category){
      throw new HttpException(`Something went wron`,HttpStatus.NOT_FOUND);
    }
    return category;
  }

  async findAll():Promise<Category[]> {
    const categories= await this.prismaService.category.findMany({});
    if(!categories){
      throw new HttpException(`Something went wron`,HttpStatus.NOT_FOUND);
    }
    return categories;
  }

  async findOne(categoryId:number) :Promise<Category>{
    const category=await this.prismaService.category.findFirst(
      {
        where:{
          id:categoryId
        }
      }
    );
    if(!category){
      throw new HttpException(`Category not found`,HttpStatus.NOT_FOUND);
    }
    return category;
  }

  update(id: number, updateCategoryDto: UpdateCategoryDto) {
    return `This action updates a #${id} category`;
  }

  remove(id: number) {
    return `This action removes a #${id} category`;
  }
}
