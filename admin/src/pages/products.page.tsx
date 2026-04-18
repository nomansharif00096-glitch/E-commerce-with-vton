import React, {} from 'react'
import {useNavigate} from 'react-router-dom';

interface Product{
  _id: string ,
  name : string ,
  price: string ,
  categoryId: string
}

const products : React.FC= () => {
  const navigate = useNavigate();

  var products : Product[] = [
    {
      _id: "1" ,
      name: "shirt" ,
      price: "120" ,
      categoryId:"12345"
    }
  ];
  
  const updateproduct = (productId : string) => {
    navigate(`/update-product/${productId}`)
  }

  const deleteProduct = (productId: string) => {
    if (window.confirm("Are you sure you want to delete this product?")){
      products = products.filter((product) => product._id != productId);
      console.log(`Delete the product ID: ${productId}`);
    }
  }



  return (
    <>
        <div className='max-w-7xl mx-auto p-6'>
          <h2 className="text-2xl font-bold mb-6">Product Management</h2>
          <div className="overflow-x-auto shadow-md sm:rounded-lg">
            <table className="min-w-full text-left text-gray-500">
              <thead className="bg-gray-100 text-xs uppercase text-gray-700">
                <tr>
                  <td className="py-3 px-4">Name</td>
                  <td className="py-3 px-4">Price</td>
                  <td className="py-3 px-4">Category</td>
                  <td className="py-3 px-4">Actions</td>
                </tr>
              </thead>

              <tbody>
                {products.length > 0
                  ? products.map((product) => (
                    <tr key={product._id} className='broder-b hover:border-gray-50 cursor-pointer'>
                      <td className="p-4 font-medium text-gray-900 whitespace-nowrap">{product.name}</td>
                      <td className="p-4">{product.price}</td>
                      <td className="p-4">{product.categoryId}</td>
                      <td className="p-4">
                        <button onClick={() => {updateproduct(product._id)}} className="w-full sm:w-fit bg-blue-400 text-white
                         px-2 py-1 mr-2 hover:bg-blue-500 rounded ">
                          Edit
                        </button>

                        <button onClick={() => {deleteProduct(product._id)}} className='bg-red-500 hover:bg-red-600
                         px-3 py-1 mr-2 text-white rounded'>
                          Delete
                        </button>
                      </td>
                    </tr>
                  ))
                  : <tr>
                    <td colSpan={4} className='p-4 text-center text-gray-700'>No product to show</td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        </div>
    </>
  )
}

export default products