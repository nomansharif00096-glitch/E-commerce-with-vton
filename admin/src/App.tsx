
import {Route , Routes} from "react-router-dom";
import { Navigate } from "react-router-dom";
// LAYOUTS...
import UserLayout from "./pages/layouts/userLayout.page";
import AdminLayout from './pages/layouts/adminLayout.page';
// PAGES...
import Dashboard from "./pages/dashboard.page";
import Products from './pages/products.page';
import AddProduct from './pages/addproduct.page';
import UpdateProduct from './pages/updateproduct.page';
import Orders from './pages/orders.page';
import Users from './pages/users.page';
import Login from './pages/login.page';
import Signup from './pages/signup.page';
import axios from "axios";
import { useContext, useEffect, useState } from "react";
import { AppContext } from "./context/AppContext";
const App = () => {
  const context = useContext(AppContext);
  const user = context?.user;
  const token = context?.token;

  useEffect(() => {
    console.log("State Token: " , token)

  } , [user]);
  
  return (
    <>
      <div>
        <Routes>
          
          <Route path='/' element={user ? <AdminLayout/>  : <Navigate to={"/user/login"}/>}>
            <Route index element={<Dashboard/>} />
            <Route path='add-product' element={<AddProduct/>}/>
            <Route path='products' element={<Products/>}/>
            <Route path='update-product/:id' element={<UpdateProduct/>}/>
            <Route path='orders' element={<Orders/>}/>
          </Route>

          <Route path="/user" element={!user ? <UserLayout/> : <Navigate to={"/"}/>}>
            <Route path='sign-up' element={<Signup/>}/>
            <Route path='login' element={<Login/>}/>
          </Route>
        </Routes>
      </div>
    </>
  )
}

export default App
