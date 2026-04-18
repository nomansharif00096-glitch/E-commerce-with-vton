import React, {createContext, useEffect, useState} from "react";
import axios from "axios";



interface User {
    email: string ,
    name: string ,
    password: string ,
    address: string ,
    createdAt: Date,
    updatedAt: Date ,
    id: number
}

interface Product {
    name: string;
    ProductImage: {
        url: string;
    }[] ,
    createdAt: Date;
    updatedAt: Date;
    id: number;
    price: string;
    description: string;
    stock: string;
    categoryId: number;
}

interface AppContextType {
    user: User | undefined,
    setUser: React.Dispatch<React.SetStateAction<User | undefined>> ,
    token: string | undefined,
    setToken : React.Dispatch<React.SetStateAction<string | undefined>>
    products: Product | undefined, 
    fetchProduct:  (id: number) => Promise<void>
}
export const AppContext = createContext<AppContextType | null>(null);

export const AppContextProvider: React.FC<React.PropsWithChildren> = (props) => {
    const backendUrl = import.meta.env.VITE_BACKEND_URL;
    // STATES...
    const [user , setUser] = useState<User>();
    const [products , setProducts] = useState<Product>();
    const [token , setToken] = useState<string>();
    // TODO: MANAGE THE ORDERS STATE WHEN THE FUNCTIONLITY IS ADDED IN THE BACKED & ALSO THERE IS NO ENDPOINT IN BACKEND TO ADMIN'S PRODUCTS....
    // const [orders , setOrders] = useState();


    useEffect(() => {
        if (user){
            // fetchProduct(user.id);
        }
    },[user]);

    const fetchProducts = async () => {
        const {data} = await axios.get(`${backendUrl}/products`);
        if (data.products){
            setProducts(data.products);
        }else{
            // SHOW TOAST ERROR...
        }
    }
    

    const fetchProduct = async (id: number) => {
        const {data} = await axios.get(`${backendUrl}/products/${id}`);
        if (data.product.length > 0){
            // SET STATE OF THE PRODUCT THAT'S BEING UPDATED AND MOVE THIS METHOD TO UPDATE PAGE...
        }
    }


    const value : AppContextType = {
        user ,
        setUser,
        token , 
        setToken ,
        products ,
        fetchProduct ,
    }

    return (
        <AppContext.Provider value={value}>
            {props.children}
        </AppContext.Provider>
    )
} 
