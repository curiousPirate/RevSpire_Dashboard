import "./App.css";
import { Home } from "./components/home";
import { Sidebar } from "./components/sidebar";
import { Header } from "./components/header";
import { useEffect, useState } from "react";
import { createContext } from "react";
import "./variables.css";
import axios from "axios";

export const globalContext = createContext(null);

function App() {
  const [theme, setTheme] = useState("light");
  const [responseData, setResponseData] = useState(null);
  const [sortOption, setSortOption] = useState("");
  const [order, setOrder] = useState("");
  const [viewer_id, setViewer_id] = useState("");
  const [folder_id, setFolder_id] = useState("");
  const [sidebarOpen, setSidebarOpem] = useState(false);

  // Find the name that matches the viewer_id from data.js

  const toggleSidebar = () => {
    setSidebarOpem(!sidebarOpen);
    console.log("toggle clicked");
  };
  const toggleTheme = () => {
    setTheme(theme === "dark" ? "light" : "dark");
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.post(
          "http://localhost:3001/view-content-and-folders-sorted",
          {
            viewer_id: viewer_id || "IGH141585754362",
            folder_id: folder_id || "WRS791262501655",
            sortOption: sortOption,
            order: order,
          }
        );

        setResponseData(response.data.items);
      } catch (error) {
        console.error("Error making POST request:", error.message);
      }
    };

    fetchData();
  }, [viewer_id, folder_id, sortOption, order]);

  return (
    <globalContext.Provider
      value={{
        theme,
        toggleTheme,
        responseData,
        setOrder,
        setSortOption,
        order,
        sortOption,
        setViewer_id,
        setFolder_id,
        toggleSidebar,
        sidebarOpen,
        viewer_id,
      }}
    >
      <div className="app-container" id={theme}>
        <Sidebar />
        <div className="content-container">
          <Header />
          <Home />
        </div>
      </div>
    </globalContext.Provider>
  );
}

export default App;
