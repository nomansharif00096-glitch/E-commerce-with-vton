import { HttpException, HttpStatus, Injectable, PipeTransform } from "@nestjs/common";

const MAX_FILE_SIZE= 2*1024*1024;

@Injectable()
export class FileTypeValidationPipe implements PipeTransform{
  private allowedMimetype=['image/png','image/jpeg','image/jpg'];

  transform(files:{images?:Express.Multer.File[]}) {

    if(!files || !files.images || files.images.length===0){ 
        return files;
    }    

    for(const file of files.images){
        if(!file.mimetype ||!this.allowedMimetype.includes(file.mimetype.toLowerCase())){
            throw new HttpException(
                `Invalid file type ${file.mimetype}. Allowed types are ${this.allowedMimetype.join(', ')}`,
                HttpStatus.UNPROCESSABLE_ENTITY);
        }
        if(file.size>MAX_FILE_SIZE){
            throw new HttpException(
                `File size exceeds the limit of ${MAX_FILE_SIZE/(1024*1024)} MB`,
                HttpStatus.UNPROCESSABLE_ENTITY
            )
        }
    }
    return files;
  }

}