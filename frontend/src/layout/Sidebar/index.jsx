import { Menu } from "antd";
import React from "react";
import { AiOutlineCaretRight, AiOutlineCaretLeft } from "react-icons/ai";
import {
  LaptopOutlined,
  NotificationOutlined,
  UserOutlined
} from "@ant-design/icons";
import { PRIMARY_COLOR } from "../../utils/constants/app-constants";

const Sidebar = (props) => {
  const { collapse, setCollapse } = props;

  const items2 = [UserOutlined, LaptopOutlined, NotificationOutlined].map(
    (icon, index) => {
      const key = String(index + 1);
      return {
        key: `sub${key}`,
        icon: React.createElement(icon),
        label: `subnav ${key}`,
        children: new Array(4).fill(null).map((_, j) => {
          const subKey = index * 4 + j + 1;
          return {
            key: subKey,
            label: `option${subKey}`
          };
        })
      };
    }
  );

  return (
    <div>
      <button
        style={{
          position: "absolute",
          background: "#e5e4e4",
          border: `1px solid ${PRIMARY_COLOR}`,
          borderRadius: "50%",
          height: 25,
          textAlign: "center",
          padding: "5px",
          width: 25,
          right: -10,
          bottom: 30,
          color: PRIMARY_COLOR,
          zIndex: 99,
          cursor: "pointer"
        }}
        onClick={() => setCollapse(!collapse)}
      >
        {collapse ? <AiOutlineCaretRight /> : <AiOutlineCaretLeft />}
      </button>
      <div className="logo" />
      <Menu
        mode="inline"
        defaultSelectedKeys={["1"]}
        defaultOpenKeys={["sub1"]}
        style={{ height: "100%", borderRight: 0 }}
        items={items2}
      />
    </div>
  );
};

export default Sidebar;
