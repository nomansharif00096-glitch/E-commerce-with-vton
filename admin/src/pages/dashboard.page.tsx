import React, { useContext } from 'react'
import { Link } from 'react-router-dom';
import { AppContext } from '../context/AppContext';

interface Order {
  _id : string ,
  user: {
    name: string
  } , 
  totalPrice: string , 
  status: string
}

const dashboard : React.FC = () => {


  const orders:Order[] = [
    {
      _id: "1" ,
      user: {
        name:"papan"
      },
      totalPrice: "60" ,
      status: "Processing"
    } ,
    {
      _id: "2" ,
      user: {
        name:"abc"
      },
      totalPrice: "120" ,
      status: "Processing"
    } ,
];

  return (
    <>
      <div className='max-w-7xl mx-auto p-6'>
        <h1 className='text-3xl font-bold mb-6'>Admin Dashboard</h1>
        <div className='grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6'>
          {/* REVENUE CARD */}
          <div className='p-4 shadow-md rounded-lg'>
            <h2 className='font-semibold text-xl'>Revenue</h2>
            <p className='text-2xl'>10000</p>
          </div>

          {/* TOTAL ORDER & MANAGE PRODUCT CARD */}
          <div className='p-4 shadow-md rounded-lg'>
            <h2 className='font-semibold text-xl'>Total Orders</h2>
            <p className='text-2xl'>5</p>
            <Link to={"/orders"} className='text-blue-500 hover:underline'>Manage orders</Link>
          </div>

          {/* TOTAL PRODUCTS & MANAGE PRODUCTS */}
          <div className='p-4 shadow-md rounded-lg'>
            <h2 className='font-semibold text-xl'>Total Products</h2>
            <p className='text-2xl'>3</p>
            <Link to={"/products"} className='text-blue-500 hover:underline'>Manage Products</Link>
          </div>
        </div>

        {/* RECENT ORDERS */}
        <div className="mt-6">
          <h2 className="text-2xl font-bold mb-4">Recent Orders</h2>
          <div className="overflow-x-auto">
            <table className="min-w-full text-2xl text-gray-500">
              <thead className='bg-gray-100 text-xs uppercase text-gray-700 text-left'>
                <tr>
                  <th className="py-3 px-4">Order ID</th>
                  <th className="py-3 px-4">User</th>
                  <th className="py-3 px-4">Price</th>
                  <th className="py-3 px-4">Status</th>
                </tr>
              </thead>

              <tbody>
                {orders.length > 0 
                  ? orders.map((order) => (
                    <tr key={order._id} className="border-b border-gray-300 hover:bg-gray-50 cursor-pointer text-xl">
                      <td className="p-4 ">{order._id}</td>
                      <td className="p-4">{order.user.name}</td>
                      <td className="p-4">{order.totalPrice}</td>
                      <td className="p-4">{order.status}</td>
                    </tr>
                  ))
                  : (
                    <tr>
                      <td colSpan={4} className='p-4 text-center text-gray-500'>No recent orders found</td>
                    </tr>
                  )
                }
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </>
  )
}

export default dashboard

// TODO: FETCH DATA FROM SERVER...