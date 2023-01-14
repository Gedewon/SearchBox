import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';


function App() {
  const [searchTerm,setSearchTerm] = useState("");
  let searchResults = [];




  return (
    <main>
      <h1>Welcome</h1>
      <input type="text" placeholder='search input'/>
      {searchResults.length > 0 && (
        searchResults.map((element, index)=><p key={index}>{element}</p>)
        )
      } 
   </main>
    );
}


const root = createRoot(document.getElementById('root'));
root.render(<App/>);

