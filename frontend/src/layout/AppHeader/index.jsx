import { Button, Col, Divider, Dropdown, Menu, Row, Space } from "antd";
import Title from "antd/es/typography/Title";
import React from "react";
import { BsGrid3X3GapFill } from "react-icons/bs";
import { BiUserCircle } from "react-icons/bi";
import { WHITE_COLOR } from "../../utils/constants/app-constants";
import ModuleMenuItem from "./ModuleMenuItem";
import setupSvg from "../../utils/svg/setup-svg.svg";
import operationSvg from "../../utils/svg/operation-svg.svg";
import salesSvg from "../../utils/svg/sales-svg.svg";
import customerSvg from "../../utils/svg/customer-svg.svg";
import financeSvg from "../../utils/svg/finance-svg.svg";
import assetSvg from "../../utils/svg/asset-svg.svg";
import inventorySvg from "../../utils/svg/inventory-svg.svg";
import reportSvg from "../../utils/svg/report-svg.svg";

const AppHeader = () => {
  return (
    <Row>
      <Col span={12}>
        <Space direction="horizontal">
          <Dropdown
            overlay={() => (
              <div
                style={{
                  width: "30vw",
                  background: WHITE_COLOR,
                  boxShadow: "0 0 5px gray",
                  padding: 10,
                  borderRadius: 5
                }}
              >
                <Row gutter={[8, 8]}>
                  <ModuleMenuItem label="Sales" svg={salesSvg} />
                  <ModuleMenuItem label="Finance" svg={financeSvg} />
                  <ModuleMenuItem label="Operations" svg={operationSvg} />
                  <ModuleMenuItem label="Setup" svg={setupSvg} />
                  <ModuleMenuItem label="Customers" svg={customerSvg} />
                  <ModuleMenuItem label="Inventory" svg={inventorySvg} />
                  <ModuleMenuItem label="Assets Mngt" svg={assetSvg} />
                  <ModuleMenuItem label="Reports" svg={reportSvg} />
                </Row>
              </div>
            )}
            placement="bottomRight"
            arrow
          >
            <Button type="text" style={{ color: WHITE_COLOR, padding: 5 }}>
              <BsGrid3X3GapFill style={{ height: 22, width: 22 }} />
            </Button>
          </Dropdown>
          <Title level={3} style={{ color: WHITE_COLOR }}>
            Logistics ERP
          </Title>
        </Space>
      </Col>
      <Col span={12}>
        <div style={{ display: "flex", flexDirection: "row-reverse" }}>
          <Dropdown
            overlay={() => (
              <div
                style={{
                  background: WHITE_COLOR
                  // borderRadius: 5
                }}
              >
                <Menu>
                  <Menu.Item>Profile</Menu.Item>
                  <Menu.Item>Change Password</Menu.Item>
                  <Divider style={{ margin: 5 }} />
                  <Menu.Item>Logout</Menu.Item>
                </Menu>
              </div>
            )}
            placement="bottomRight"
            arrow
          >
            <Button
              type="text"
              style={{
                color: WHITE_COLOR,
                padding: 5,
                margin: 5,
                height: "auto"
              }}
            >
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "space-between",
                  height: 30
                }}
              >
                <p style={{ fontSize: 25, margin: 0 }}>
                  <BiUserCircle style={{ marginRight: 5 }} />
                </p>
                <p style={{ margin: 0 }}>Syed Arbaz Ahmed Kirmani</p>
              </div>
            </Button>
          </Dropdown>
          <Button
            type="text"
            style={{
              fontSize: 30,
              color: WHITE_COLOR,
              height: "min-content",
              padding: 5
            }}
          ></Button>
        </div>
      </Col>
    </Row>
  );
};

export default AppHeader;
