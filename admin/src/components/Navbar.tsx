import React from 'react';
import {Link} from "react-router-dom";
import {HiOutlineUser , HiBars3BottomRight} from "react-icons/hi2";

interface NavbarProps {
        user?: {}
    }
const Navbar : React.FC<NavbarProps> = (props) => {
    

    // USER STATE...
  return (
    <>
        <nav className="bg-gray-900 flex items-center justify-between py-4 px-6 border-b border-gray-200">
            {/* LEFT SIDE LOGO */}
            <div>
                <Link to={"/"} className='text-2xl font-medium text-white'>LOGO</Link>
            </div>

            {/* USER ICON OR SIGN IN */}

            <div className='hidden md:flex space-x-6'>
                {
                  !props.user  // IF USER NOT THEN DISPLAY SIGN-IN LINKS ELSE SHOW USER-ICON
                  ?  <div>
                        <Link to={"/user/login"} className="text-white text-sm hover:border-b font-medium uppercase">
                            sign in
                        </Link>
                    </div>
                  :  <div className="flex items-center space-x-4">
                        <Link to={"/user/profile"} className='hover:border-b'>
                            <HiOutlineUser className='size-6 text-white'/>
                        </Link>
                    </div>
                }
            </div>
        </nav>
    </>
  )
}

export default Navbar