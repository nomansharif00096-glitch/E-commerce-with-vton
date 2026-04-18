import React from 'react'


interface Order {
  _id: string ,
  user: {
    name: string
  } , 
  status: string,
  totalPrice: string
}
const orders : React.FC = () => {
  const orders : Order[] = [
    {
      _id: "123" ,
      user: {
        name: "Papan"
      },
      status: "Processing" ,
      totalPrice: "120"
    },
    {
      _id: "321" ,
      user: {
        name: "goum naam"
      },
      status: "Processing" ,
      totalPrice: "220"
    },
  ];
  

  const handleChange = (id : string , event: React.ChangeEvent<HTMLSelectElement>) => {
    orders.forEach((order) => order._id == id ? order.status = event.target.value : null) 
    console.log(orders);
  }
  
  const handleAsDelivered = (event : React.MouseEvent<HTMLButtonElement> , id : String) => {
    orders.forEach((order) => order._id == id ? order.status = "Delivered" : null) 
    console.log(orders);
  }
  return (
    <>
      <div className='max-w-7xl mx-auto p-6'>
        <h2 className="text-2xl font-bold mb-6">Order Management</h2>
        <div className="overflow-x-auto shadow-md sm:rounded-lg">
          <table className="min-w-full text-left text-gray-500" >
            <thead className="bg-gray-100 text-xs uppercase text-gray-700">
              <tr>
                <th className="py-3 px-4">Order ID</th>
                <th className="py-3 px-4">Customer</th>
                <th className="py-3 px-4">Total Price</th>
                <th className="py-3 px-4">Status</th>
                <th className="py-3 px-4">Action</th>
              </tr>
            </thead>

            <tbody>
              {
                orders.length > 0
                ? orders.map((order) => (
                  <tr key={order._id} className='border-b hover:bg-gray-50 cursor-pointer'>
                    <td className="p-4 font-medium text-gray-900 whitespace-nowrap">
                      #{order._id}
                    </td>
                    <td className="p-4">{order.user.name}</td>
                    <td className="p-4">{order.totalPrice}</td>
                    <td className="p-4">{
                      <select value={order.status} 
                       className='bg-gray-50 border border-gray-300 text-gray text-sm rounded-lg py-1.5
                       focus:ring-blue-500 focus:border-blue-500'
                       onChange={(e) => {handleChange(order._id , e)}}
                      >
                        <option value={"Processing"}>Processing</option>
                        <option value={"Shipped"}>Shipped</option>
                        <option value={"Delivered"}>Delivered</option>
                        <option value={"Cancelled"}>Cancelled</option>
                      </select>
                      }
                    </td>
                    <td className="p-4">
                      <button 
                       className='bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600' 
                       onClick={(e) => {handleAsDelivered(e , order._id)}} 
                      >
                        Mark as delivered
                      </button>
                    </td>
                  </tr>
                  ))
                : (<tr> <td colSpan={5}> No orders to show</td></tr>)
              }
            </tbody>
          </table>
        </div>
      </div>
    </>
  )
}

export default orders