import React, { useState, useEffect, useCallback, useMemo } from 'react';
import { createRoot } from 'react-dom/client';
import axios from 'axios';

function App() {
  const [searchTerm,setSearchTerm] = useState("");
  const [searchResults,setSearchResults] = useState([]);

  useEffect(() => {
    let isDisposed = false;

    (async()=>{
      const response =  await axios.get(`/api/v1/search?q=${searchTerm}`);

      if(!isDisposed) setSearchResults(response.data);
    })();

    return () => {
      isDisposed = true;
    }
  }, [searchTerm])
  
 
  const handleClick = useCallback(
    (e) => {
      setSearchTerm(e.target.innerHTML)
    },
    [],
  );

  let sortedSearchResult = useMemo(() => searchResults.sort((a,b)=>b[1]-a[1]), [searchResults])

  return (
    <main>
      <h1>Welcome</h1>
      <input type="text" placeholder='search input' onChange={(e)=>setSearchTerm(e.target.value)} value={searchTerm}/>
      <ul>
      {sortedSearchResult.length > 0 && (
        searchResults.map((element, index)=><li key={index} onClick={handleClick}>{element}</li>)
        )
      } 
      </ul>
   </main>
    );
}


const root = createRoot(document.getElementById('root'));
root.render(<App/>);

