import { ConfigProvider, Layout } from "antd";
import { Content, Header } from "antd/es/layout/layout";
import Sider from "antd/es/layout/Sider";
import { useState } from "react";
import "./App.css";
import MainLayout from "./layout";
import { PRIMARY_COLOR } from "./utils/constants/app-constants";
import "antd/dist/reset.css";

function App() {
  return (
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: PRIMARY_COLOR
        }
      }}
    >
      <div className="App">
        <MainLayout />
      </div>
    </ConfigProvider>
  );
}

export default App;
