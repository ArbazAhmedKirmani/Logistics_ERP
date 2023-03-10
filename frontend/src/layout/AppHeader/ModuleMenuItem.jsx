import { Button, Col } from "antd";
import Title from "antd/es/typography/Title";
import React from "react";

const ModuleMenuItem = (props) => {
  const { label, svg = null, disabled = false, onclick } = props;
  return (
    <Col xxl={8} xl={12} md={12} sm={24}>
      <Button
        type="text"
        onClick={onclick}
        style={{border:'none',
          padding: 15,
          height: "auto",
          width: "100%"
        }}
        disabled={disabled}
      >
        <div
          style={{
            display: "flex",
            justifyContent: 'flex-start',
            alignItems: "center",
            paddingLeft: 10
          }}
        >
          <div
            style={{
              display: "flex"
            }}
          >
            <img
              src={svg}
              style={{ width: 30, height: 30, marginRight: 10 }}
              alt="setupsvg"
            />
            <Title level={5} style={{ margin: 2 }}>
              {label}
            </Title>
          </div>
        </div>
      </Button>
    </Col>
  );
};

export default ModuleMenuItem;
