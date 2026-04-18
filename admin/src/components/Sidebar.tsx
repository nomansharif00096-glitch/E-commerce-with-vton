import React from 'react'
import { FaBoxOpen, FaSignOutAlt } from 'react-icons/fa'
import { FaCirclePlus } from 'react-icons/fa6'
import { LuNotebookText } from 'react-icons/lu'
import { MdSpaceDashboard } from 'react-icons/md'
import { Link , NavLink, useNavigate} from 'react-router-dom'

interface Props {
    userName?: string
}
const Sidebar : React.FC<Props> = ({userName}) => {
  const navigate = useNavigate();
  
  const handleLogout = () => {
    navigate("/user/login")
  }
    return (
    <>
        <div className='p-6'>
            <div className='mb-6'>
                <Link to={"/"} className='text-2xl font-medium'>{userName}</Link>
            </div>
            
            {/* SIDEBAR LINKS */}
            <nav className='flex flex-col space-y-2'>
                <NavLink to={"/"} className={({isActive}) => isActive 
                 ? "bg-gray-700 text-white py-3 px-4 rounded flex items-center space-x-2 mb-4"
                 : "text-gray-300  hover:bg-gray-700 hover:text-white py-3 px-4 rouned flex items-center space-x-2 mb-4"
                }>
                    <MdSpaceDashboard size={23}/>
                    <span>Dashboard</span>   
                </NavLink>
                <NavLink to={"/orders"} className={({isActive}) => isActive   
                 ? "bg-gray-700 text-white py-3 px-4 rounded flex items-center space-x-2 mb-4"
                 : "text-gray-300  hover:bg-gray-700 hover:text-white py-3 px-4 rouned flex items-center space-x-2 mb-4"
                }>
                    <LuNotebookText size={23}/>
                    <span>Orders</span>   
                </NavLink>
                <NavLink to={"/products"} className={({isActive}) => isActive   
                 ? "bg-gray-700 text-white py-3 px-4 rounded flex items-center space-x-2 mb-4"
                 : "text-gray-300  hover:bg-gray-700 hover:text-white py-3 px-4 rouned flex items-center space-x-2 mb-4"
                }>
                    <FaBoxOpen size={23}/>
                    <span>Products</span>   
                </NavLink>
                <NavLink to={"/add-product"} className={({isActive}) => isActive   
                 ? "bg-gray-700 text-white py-3 px-4 rounded flex items-center space-x-2 mb-4"
                 : "text-gray-300  hover:bg-gray-700 hover:text-white py-3 px-4 rouned flex items-center space-x-2 mb-4"
                }>
                    <FaCirclePlus size={23}/>
                    <span>Add Product</span>   
                </NavLink>
            </nav>

            <div className="mt-6">
                <button onClick={handleLogout} className='w-full bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded 
                 flex items-center justify-center space-x-2'>
                    <FaSignOutAlt/>
                    <span>
                        logout
                    </span>
                </button>
            </div>

        </div>
    </>
  )
}

export default Sidebar

// TODO: ADD LOGOUT FUNCTIONALITY ON LOGOUT BUTTON....