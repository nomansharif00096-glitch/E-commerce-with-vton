import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { UserModule } from 'src/user/user.module';
import { JwtModule } from '@nestjs/jwt';
import { authConstants } from './auth_constants';
import { JwtStrategy } from './jwt-strategy';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  imports:[
  UserModule,
  PrismaModule,
  JwtModule.register(
    {
      secret:authConstants.secret,
      signOptions:{
        expiresIn:"1d"
      }
    }
  ),
  ],
  controllers: [AuthController],
  providers: [AuthService,JwtStrategy],
})
export class AuthModule {}
