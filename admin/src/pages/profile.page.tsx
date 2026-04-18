import React from 'react'
import MyOrders from "./myOrders.page";

// COMPONENTS...
import Navbar from '../components/navbar'
const profile : React.FC = () => {
  return (
    <>
      <div>
        <Navbar/>
      </div>

      <div className='min-h-screen flex flex-col'>
        <div className='grow container mx-auto p-4 md:p-6'>
          <div className='flex flex-col md:flex-row md:space-x-6 space-y-6 md:space-y-0'>
            {/* USER DETAILS */}
            <div className='w-full md:w-1/3 lg:md-1/4 shadow-md rounded-lg p-6'>
              <h1 className='text-2xl md:text-3xl font-bold mb-4'>USER NAME GOES HERE</h1>
            <p className="text-lg text-gray-600 mg-4">user@gmail.com</p>
              <button className="w-full bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600 mx-auto mt-2">
                Logout
              </button>
            </div>

            {/* USER'S ORDERS TABLE */}
            <div className="w-full md:w-2/3 lg:w-3/4">
              <MyOrders/>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}

export default profile