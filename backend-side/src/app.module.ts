import { Global, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { CategoryModule } from './category/category.module';
import { ProductsModule } from './products/products.module';
import { ConfigModule } from '@nestjs/config';
import { MediaModule } from './media/media.module';
import app_config from './config/app_config';

@Module({
  imports: [
    UserModule, 
    PrismaModule, 
    AuthModule, 
    CategoryModule, 
    ProductsModule,
    ConfigModule.forRoot({isGlobal:true,load:[app_config]}),
    MediaModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
