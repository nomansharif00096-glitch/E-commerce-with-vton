import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { v2 as cloudinary, UploadApiErrorResponse, UploadApiResponse } from 'cloudinary';

@Injectable()
export class MediaService {
    constructor(private readonly configService:ConfigService){
        cloudinary.config({
            cloud_name:configService.get<string>('appConfig.cloudinaryName'),
            api_key:configService.get<string>('appConfig.cloudinaryApiKey'),
            api_secret:configService.get<string>('appConfig.cloudinarySecretKey')
        });
    }

    async uploadImages(file:Express.Multer.File):Promise<string>{
        return new Promise((resolve,reject)=>{
            cloudinary.uploader.upload_stream(
                {folder:"products",resource_type:"image"},
                (error: UploadApiErrorResponse | undefined, result: UploadApiResponse | undefined)=>{
                    if(error) {
                        reject(error);
                    }else if(result) {
                    resolve(result.secure_url);
                } else {
                    reject(new Error("Unknown upload error"));
                }
                }
            ).end(file.buffer);
        });
    }

    async deleteImage(imageUrl: string): Promise<any> {
    try {
      // Extract public_id from Cloudinary URL
      const publicId = imageUrl;
      
      if (!publicId) {
        throw new Error('Invalid Cloudinary URL format');
      }

      // Delete from Cloudinary
      const result = await cloudinary.uploader.destroy(publicId);
      
      console.log(`Image deleted from Cloudinary: ${publicId}`, result);
      return result;
    } catch (error) {
      console.error('Error deleting image from Cloudinary:', error);
      throw new Error(`Failed to delete image: ${error.message}`);
    }
  }
}
