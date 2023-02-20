import React, { useState, useEffect, useCallback, useMemo } from 'react';
import { createRoot } from 'react-dom/client';
import axios from 'axios';

function App() {
  const [searchTerm,setSearchTerm] = useState("");
  const [searchResults,setSearchResults] = useState({});
  const [userId,setUserId] = useState(null);

  useEffect(() => {
    let isDisposed = false;

    (async()=>{
      const userId = localStorage.getItem('userId')
      const response =  await axios.get(`/api/v1/search?q=${searchTerm}&user=${userId}`);

      if(!isDisposed) setSearchResults(response.data);
    })();

    return () => {
      isDisposed = true;
    }
  }, [searchTerm])
  

  useEffect(() => {
    
    let isDisposed = false;

    if(!localStorage.getItem('userId')){
      //create a simple user here
      (async()=>{
        const response = await axios.get(`/api/v1/user`);
        const userId = response.data
        if(!isDisposed) {
          setUserId(userId);
          localStorage.setItem('userId',JSON.stringify(userId))
        }
      })();
    }
    
    
    return () => {
      isDisposed=true;
    }
  }, [])
  
 
  const handleClick = useCallback(
    (e) => {
      setSearchTerm(e.target.innerHTML)
    },
    [],
  );
   
  let sortedUserSearchResult = useMemo(()=>searchResults?.user_history?.sort((a,b)=>b[1]-a[1]),[searchResults?.user_history]);
  let sortedGlobalSearchResult =  useMemo(()=>searchResults?.global_history?.sort((a,b)=>b[1]-a[1]),[searchResults?.global_history]);

 
  return (
    <main>
      <h1>Welcome</h1>
      <input type="text" placeholder='search input' onChange={(e)=>setSearchTerm(e.target.value)} value={searchTerm}/>
      <ul>
      {sortedUserSearchResult?.length > 0 && (
        sortedUserSearchResult.map((element, index)=><li key={index} className='history' onClick={handleClick}>{element}</li>)
        )
      }
      {sortedGlobalSearchResult?.length > 0 && (
        sortedGlobalSearchResult?.map((element, index)=><li key={index} onClick={handleClick}>{element}</li>)
        )
      }  
      </ul>
   </main>
    );
}


const root = createRoot(document.getElementById('root'));
root.render(<App/>);

