import React, { useEffect, useState } from 'react'
import axios from 'axios';

const Admin = () => {
    const [category, setCategory] = useState('');
    const [subcategory, setSubcategory] = useState('');
    const [productName, setProductName] = useState('');
    const [productCompany, setProductCompany] = useState('');
    const [productPrice, setProductPrice] = useState(0);
    const [productPriceBeforeDiscount, setProductPriceBeforeDiscount] = useState(0);
    const [productPriceAfterDiscount, setProductPriceAfterDiscount] = useState(0);
    const [productDescription, setProductDescription] = useState('');
    const [shippingCharge, setShippingCharge] = useState(0);
    const [productAvailability, setProductAvailability] = useState('');
    const [img1, setImg1] = useState('')
    const [img2, setImg2] = useState('')
    const [img3, setImg3] = useState('')
    const [list, setList] = useState([]);
    const [lists, setLists] = useState([]);

    function handleImg1(e) {
        setImg1(e.target.files[0]);
    }

    function handleImg2(e) {
        setImg2(e.target.files[0]);
    }

    function handleImg3(e) {
        setImg3(e.target.files[0]);
    }

    function handleSubmit(e) {

        e.preventDefault();

        const formData = new FormData();
        
        formData.append('category', category)
        formData.append('subcategory', subcategory)
        formData.append('productName', productName)
        formData.append('productCompany', productCompany)
        formData.append('productPrice', productPrice)
        formData.append('productPriceBeforeDiscount', productPriceBeforeDiscount)
        formData.append('productPriceAfterDiscount', productPriceAfterDiscount)
        formData.append('productDescription', productDescription)
        formData.append('shippingCharge', shippingCharge)
        formData.append('productAvailability', productAvailability)

        formData.append('img1', img1)
        formData.append('img2', img2)
        formData.append('img3', img3)


        axios.post('http://localhost:8000/saveproduct', formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
        }).then(res => console.log(res.data));
    }


    useEffect(() => {
        axios.get('http://localhost:8000/getcategories').then(res => setList(res.data));
    }, [list])

    useEffect(() => {
        axios.get('http://localhost:8000/getsubcategories').then(res => setLists(res.data));
    }, [lists])


    return (
        <>
        
        <div className='flex gap-100 mt-10'>
            
            <form onSubmit={handleSubmit} encType='multipart/form-data'>
                

                Product Category <select value={category} name="category" id="" onChange={(e) => setCategory(e.target.value)}>
                    <option value="">select category</option>
                    {
                        list.map((item, index) => (
                            <option key={index} value={item.id}>{item.name}</option>
                        ))
                    }
                </select>
                <br /><br />


                Product Sub Category <select value={subcategory} name="subcategory" id="" onChange={(e) => setSubcategory(e.target.value)}>
                    <option value="">select sub category</option>
                    {
                        lists.map((item, index) => (
                            <option key={index} value={item.id}>{item.subcat}</option>
                        ))
                    }
                </select>
                <br /><br />

                Product Name<input type="text" name='productName' value={productName} onChange={(e) => setProductName(e.target.value)} /> <br /><br />
                Company Name <input type="text" name='productCompany' value={productCompany} onChange={(e) => setProductCompany(e.target.value)} /> <br /><br />
                Product Price <input type="text" name='productPrice' value={productPrice} onChange={(e) => setProductPrice(e.target.value)} /> <br /><br />
                Product Price Before Discount <input type="text" name='productPriceBeforeDiscount' value={productPriceBeforeDiscount} onChange={(e) => setProductPriceBeforeDiscount(e.target.value)} /> <br /> <br />
                Product Price After Discount <input type="text" name='productPriceAfterDiscount' value={productPriceAfterDiscount} onChange={(e) => setProductPriceAfterDiscount(e.target.value)} /> <br /> <br />
                Product Description <input type="text" name='productDescription' value={productDescription} onChange={(e) => setProductDescription(e.target.value)} /> <br /><br />
                Shipping Charge <input type="text" name='shippingCharge' value={shippingCharge} onChange={(e) => setShippingCharge(e.target.value)} /> <br /><br />
               
                Product Availability <select name="productAvailability" value={productAvailability} id="" onChange={(e) => setProductAvailability(e.target.value)}>
                    <option value="">Select Availability</option>
                    <option value="Available">Available</option>
                    <option value="Out of Stock">Out of Stock</option>
                </select>
                <br /><br />

                Choose Image1: <input type="file" id="file" name="file" onChange={handleImg1} accept="image/*" /><br></br>
                Choose Image2: <input type="file" id="file" name="file" onChange={handleImg2} accept="image/*" /><br></br>
                Choose Image3: <input type="file" id="file" name="file" onChange={handleImg3} accept="image/*" /><br></br>
                <button className='px-8 py-2 bg-blue-600 rounded'>Add</button>

            </form>
        </div>
         </>
    )
}

export default Admin
