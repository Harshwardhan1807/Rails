import React from "react";
import { Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Navbar from "./components/Navbar";
import Rails from "@rails/ujs";
Rails.start();

function App() {
  return (
    <div style={{ margin: 0, padding: 0 }}  >
      <Navbar currentUser={window.currentUser} />
      <Routes>
        <Route path="/" element={<Home />} />
      </Routes>
    </div>
  );
}

export default App;