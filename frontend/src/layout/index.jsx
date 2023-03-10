import { Layout } from "antd";
import { Content, Header } from "antd/es/layout/layout";
import Sider from "antd/es/layout/Sider";
import React, { useState } from "react";
import { PRIMARY_COLOR } from "../utils/constants/app-constants";
import AppHeader from "./AppHeader";
import Sidebar from "./Sidebar";

const MainLayout = () => {
  const [collapse, setCollapse] = useState(false);

  return (
    <Layout>
      <Header style={{ padding: "5px 20px", background: PRIMARY_COLOR }}>
        <AppHeader />
      </Header>
      <Layout>
        <Sider
          theme="light"
          collapsed={collapse}
          style={{ height: "Calc(100vh - 64px)" }}
        >
          <Sidebar collapse={collapse} setCollapse={setCollapse} />
        </Sider>
        <Content></Content>
      </Layout>
    </Layout>
  );
};

export default MainLayout;
