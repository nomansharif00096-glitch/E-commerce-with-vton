import React, { useState} from 'react'
import { useParams } from 'react-router-dom'


interface Product {
  name?: string , 
  description?: string,
  price?: string , 
  category?: string ,
  stock?: string ,
  images?: {url?: string} [
    
  ]
}

type Files = FileList | null;
const updateproduct : React.FC = () => {

  const {id} = useParams();
  const [productData , setProductData] = useState<Product>({
    name: "product 1" ,
    description: "This is product 1" ,
    price: "60" ,
    category: "Household" ,
    stock: "12" ,
    images:[
      {url: "https://picsum.photos/150?random=1"},
      {url: "https://picsum.photos/150?random=2"}
    ]
  });

  const [files , setFiles] = useState<Files>();

  const handleChange = (event : React.ChangeEvent<HTMLInputElement>) => {
    setProductData((prev) => ({
      ...prev ,
      [event.target.name] : event.target.value
    }))
  }

  const handleTextAreaChange = (event:React.ChangeEvent<HTMLTextAreaElement>) => {
    setProductData((prev) => ({
      ...prev ,
      description: event.target.value
    }));
  }

  const handleImage = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const images = event.target.files;
    if (images?.length && images.length > 3){
      return;
      // SHOW TOAST ERROR IF FILES EXCEED THE LIMIT OF 3...
    }
    setFiles(images);
  }
  return (
    <>
        <div className='max-w-5xl mx-12 p-6 shadow-lg rounded-md'>
          <h2 className="text-3xl font-bold mb-6">Edit Product</h2>
          <form>
            {/* NAME */}
            <div className="mb-6">
              <label htmlFor="name" className="block font-semibold mb-2">Product Name</label>
              <input type="text" name="name" id="name"
               className='w-full border border-gray-300 rounded-md p-2' 
               onChange={handleChange}
               value={productData.name} 
               placeholder='enter product name'
               required
              />
            </div>

            {/* DESCRIPTION */}
            <div className="mb-6">
              <label htmlFor="description" className="block font-semibold mb-2">Description</label>
              <textarea name="description" id="description" rows={4}
                className='w-full border border-gray-300 rounded-md p-2'
                onChange={handleTextAreaChange}
                value={productData.description}
                required
              />
            </div>

            {/* PRICE */}
            <div className="mb-6">
              <label htmlFor="price" className="block font-semibold mb-2">Price</label>
              <input type="number" name="price" id="price" 
               className='w-full border border-gray-300 rounded-md p-2'
               onChange={handleChange}
               value={productData.price}
               min={0}
               required
              />
            </div>

            {/* CATEGORY */}
            <div className="mb-6">
              <label htmlFor="category" className="block font-semibold mb-2">Category</label>
              <input type="text" name="category" id="category" 
               className='w-full border border-gray-300 rounded-md p-2'
               onChange={handleChange}
               value={productData.category}
               placeholder='enter product category'
              />
            </div>

            {/* STOCK */}
            <div className="mb-6">
              <label htmlFor="stock" className="block font-semibold mb-2">Stock</label>
              <input type="number" name="stock" id="stock" 
               className='w-full border border-gray-300 rounded-md p-2'
               onChange={handleChange}
               value={productData.stock}
               min={0}
              />
            </div>

            {/* IMAGES */}
            <div className="mn-6">
              <label htmlFor="files" className="block font-semibold mb-2">Upload Image</label>
              <input type="file" name="files" id="files"
               onChange={handleImage}
              />
              <div className="flex gap-4 mt-4">
                {productData.images && productData.images.map((img , idx) => (
                  <div key={idx}>
                    <img src={img.url} alt={"Product Image"} className='size-20 object-cover rounded-md shadow-md'/>
                  </div>
                ))
                }
              </div>
            </div>

            <button type="submit" 
             className="w-full bg-green-500 text-white py-2 mt-6 rounded-md hover:bg-green-600 transition-colors"
            >
              Update Product
            </button>
          </form>
        </div>
    </>
  )
}

export default updateproduct


// TODO: ADD THE FUNCTIONALITY TO FETCH PRODUCT DATA FROM SERVER AND THEN POST THE UPDATED DATA...