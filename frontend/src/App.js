import "./App.css";
import { Sidebar } from "./components/sidebar";
import { Header } from "./components/header";
import "./variables.css";


function App() {

  return (
      <div className="app-container">
        <Sidebar />
        <div className="content-container">
          <Header />
        </div>
      </div>
  );
}

export default App;
