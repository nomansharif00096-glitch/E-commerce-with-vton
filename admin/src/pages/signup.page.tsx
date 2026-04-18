import React , {useState} from 'react';
import { Link } from 'react-router-dom';
import { BsEye, BsEyeSlash } from 'react-icons/bs';
import {useNavigate} from "react-router-dom";
import axios from 'axios';


interface User {
  name?: string ,
  email?: string ,
  address?: string,
  password?: string,
}

const signup: React.FC = () => {
 // STATES...
  const [userData , setUserData] = useState<User>();
  const [showPasswd , setShowPasswd] = useState<boolean>();
  const navigateTo = useNavigate();



  // EVENT HANDLER FUNCTIONS....
  const handleOnChange = (event : React.ChangeEvent<HTMLInputElement>) => {
    setUserData(
      (prevData ) : User => {
        return {
          ...prevData ,
          [event.target.name]: event.target.value ,
          ["address"]: ""
        }
      }
    );
  }

  const handleShowPasswd = () => {
    setShowPasswd(
      (prev) : boolean => {
        return !prev;
      }
    )
  }


  const signUp = async () => {
    const {data} = await axios.post("http://localhost:3002/auth/signup" , userData);
    if (data.newUser){
      navigateTo("/user/login");
    }

  }
  const handleSubmit = async (event: any) => {
    event.preventDefault();
    await signUp();
  }


  return (
    <>
      
      <div className='flex items-center justify-center'>
      <div className='w-full md:w-[70%] lg:w-1/2 flex-col justify-center items-center p-8 md:p-12'>
        <form onSubmit={handleSubmit} className='w-full bg-white p-8 rounded-lg border border-gray-300 shadow-xl'>
          <div className="flex justify-center mb-6">
            <h2 className='text-xl font-medium'>TITLE GOES HERE</h2>
          </div>
          <h2 className="text-2xl font-bold text-center mb-6">Hey there!</h2>
          <p className="text-center mb-6">Enter your email and password to Login</p>
          {/****  EMAIL *** */}
          <div className="mb-4">
            <label htmlFor="email" className="block text-sm font-semibold mb-2">Email</label>
            <input 
             type="email"
             name="email" 
             id="email"
             className='w-full border p-2'
             placeholder='enter your email'
             onChange={handleOnChange}
             value={userData?.email}
             required
             />
          </div>

          {/* *** NAME *** */}
          <div className="mb-4">
            <label htmlFor="name" className='block text-sm font-semibold mb-2'>Name</label>
            <input
             type="text"
             name="name" 
             id="name" 
             className='w-full border p-2'
             placeholder='enter your name'
             onChange={handleOnChange}
             value={userData?.name}
             required
             />
          
          </div>

          {/* *** PASSWORD *** */}
          <div className="mb-4">
            <label htmlFor="passwd" className="text-sm font-semibold mb-2">Password</label>
            <div className='flex border border-black'>
              <input 
                type={showPasswd ? "text" : "password"}
                name="password" 
                id="passwd"
                className='w-full border-r p-2'
                placeholder='enter your password'
                onChange={handleOnChange}
                value={userData?.password}
                required
             />
             <button className='p-1' type='button' onClick={handleShowPasswd}>
                <span className='text-2xl font-semibold'>
                  {showPasswd 
                  ? <BsEye/>
                  : <BsEyeSlash/>
                }
                </span>
              </button>
            </div>
          </div>
          {/* *** CONFIRM-PASSWORD *** */}
           {/* <div className="mb-4">
            <label htmlFor="passwd" className="text-sm font-semibold mb-2">Confirm password</label>
            <div className='border flex border-black'>
              <input 
                type={showPasswd ? "text" : "password"}
                name="password" 
                id="passwd"
                className='w-full border-r p-2'
                placeholder='enter your password'
                onChange={handleOnChange}
                value={userData?.password}
                required
             />
             <button className='p-1' type='button' onClick={handleShowPasswd}>
                <span className='text-2xl font-semibold'>
                  {showPasswd 
                  ? <BsEye/>
                  : <BsEyeSlash/>
                }
                </span>
              </button>
            </div>
          </div>      */}

          <button type="submit" className='w-full bg-black text-white mt-6 p-2 rounded-lg 
           font-semibold hover:bg-gray-800 transition' >
            Sign up
          </button>

          <p className="mt-6 text-center text-sm">
            Already have an account? 
            <Link to={"/user/login"} className='text-blue-500'> sign in</Link>
          </p>

        </form>
      </div>
    </div>
    </>
  )
}
export default signup;

// TODO: ADD SIGN UP FUNCTINALITY THEN REGISTER THE USER...