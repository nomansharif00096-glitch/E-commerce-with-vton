import { Injectable } from "@nestjs/common";
import { PassportStrategy } from "@nestjs/passport";
import { Strategy,ExtractJwt } from "passport-jwt";
import { authConstants } from "./auth_constants";
import { ActiveUserData } from "src/auth/interfaces/active-user-data";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy){
    constructor(){
        super({
        jwtFromRequest:ExtractJwt.fromAuthHeaderAsBearerToken(),
        ignoreExpiration:false,
        secretOrKey:authConstants.secret
      } as any);
    }

    async validate(payload:ActiveUserData){
        return {
            userId:payload.userId,
            email:payload.email
        }
    }
}