import { ConflictException, HttpException, HttpStatus, Injectable, UnauthorizedException } from '@nestjs/common';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { UserService } from 'src/user/user.service';
import { User } from "@prisma/client";
import { CreateUserDto } from 'src/user/dto/create-user.dto';
import { LoginDto } from 'src/user/dto/login.dto';
import * as bcrypt from "bcryptjs";
import { JwtService } from '@nestjs/jwt';
import { ActiveUserData } from './interfaces/active-user-data';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private userService:UserService,
    private jwtService:JwtService,
    private readonly prismaService:PrismaService
  ){}
  // Create/Signup the user by the help of (UserService)
  async signup(createUserDto:CreateUserDto):Promise<User> {
    const existingUser=await this.prismaService.user.findFirst({where:{email:createUserDto.email}});
    if(existingUser){
      throw new ConflictException('This Gmail is already in use');
    }
    const newUser=this.userService.create(createUserDto);
    return newUser;
  }
  // Login the user by the help of (UserService)
  async login(loginDto:LoginDto) {
    const user=await this.userService.findByEmail(loginDto);
    const passwordMatched=await bcrypt.compare(loginDto.password,user.password);
    if(passwordMatched){
      const payload={
        userId:user.id,
        email:user.email
      }as ActiveUserData;
      return {
      user:user,
      accessToken:this.jwtService.sign(payload)
    };
    }else{
        throw new UnauthorizedException(`Password doesn't match`);
      }
  }

  async findAll(){
      const user=await this.prismaService.user.findMany();
      if(!user){
        throw new HttpException(`No User found`,HttpStatus.NOT_FOUND);
      }
      return user;
    }

  findOne(id: number) {
    return this.userService.findOne;
  }

  update(id: number, updateAuthDto: UpdateAuthDto) {
    return `This action updates a #${id} auth`;
  }

  remove(id: number) {
    return `This action removes a #${id} auth`;
  }
}
