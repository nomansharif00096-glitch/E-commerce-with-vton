import { Module } from '@nestjs/common';
import { ProductsService } from './products.service';
import { ProductsController } from './products.controller';
import { MediaModule } from 'src/media/media.module';
import { PrismaModule } from 'src/prisma/prisma.module';
import { CategoryModule } from 'src/category/category.module';

@Module({
  imports:[MediaModule,PrismaModule,CategoryModule],
  controllers: [ProductsController],
  providers: [ProductsService],
})
export class ProductsModule {}
