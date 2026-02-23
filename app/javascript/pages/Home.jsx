import React from "react";
import { Link } from "react-router-dom";


const Home = () => {
  return (
    <div style={styles.container}>
      <h1 style={styles.title}>Streaming Platform</h1>
      <p style={styles.subtitle}>
        A simple YouTube-like streaming platform
      </p>
      <a href="/users" style={{ color: "#fff", textDecoration: "underline", marginTop: "20px" }}>
        All Users
      </a>
    </div>
  );
};

const styles = {
  container: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    height: "100vh",
    backgroundColor: "#c79090",
    margin: 0,
    boxSizing: "border-box",
    padding: "0px",
  },
  title: {
    fontSize: "48px",
    color: "#fff",
    marginBottom: "20px",
    margin: 0,
  },
  subtitle: {
    fontSize: "24px",
    color: "#fff",
  },
};

export default Home;