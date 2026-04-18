import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { User } from "@prisma/client";
import * as bcrypt from "bcryptjs";
import { LoginDto } from './dto/login.dto';

@Injectable()
export class UserService {
  constructor(private prismaService:PrismaService){}

  async create(createUserDto: CreateUserDto):Promise<User> {
  // change password into hash so we can save the password in hash format in db  
  const salt:string= await bcrypt.genSalt()
  createUserDto.password=await bcrypt.hash(createUserDto.password,salt);
  const newUser=await this.prismaService.user.create({data:createUserDto});
  if(!newUser){
    throw new HttpException(
      `Something went wrong during creating: ${createUserDto.name}`,
      HttpStatus.BAD_REQUEST
    );
  }
  // delete createUserDto.password;
    return newUser;
  }

  async findByEmail(loginDto:LoginDto) {
    // find user in db by email
    const user= await this.prismaService.user.findFirst(
      {
        where:{email:loginDto.email}
      }
    );
    if(!user){
      throw new HttpException(`User not found`,HttpStatus.NOT_FOUND);
    }
    return user;
  }

  async findAll(){
    const user=await this.prismaService.user.findMany();
    if(!user){
      throw new HttpException(`No User found`,HttpStatus.NOT_FOUND);
    }
    return user;
  }
  async findOne(id: number) {
    const user=await this.prismaService.user.findFirst(
      {
        where:{id:id}
      }
    );
    if(!user){
      throw new HttpException(`User not found`,HttpStatus.NOT_FOUND);
    }
    return user;
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`;
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
