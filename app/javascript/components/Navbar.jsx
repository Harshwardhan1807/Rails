import React from "react";
import { Link } from "react-router-dom";

const Navbar = ({}) => {
  const currentUser = window.currentUser;

  console.log("Current User in Navbar:", currentUser); 

  return (
    <nav style={styles.nav}>
      <div style={styles.logo}>
        <Link to="/" style={styles.logoLink}>Streamify</Link>
      </div>

      <div style={styles.links}>
        <div>
          {currentUser ? (
            <span>
              Welcome, {currentUser.name}!
            </span>
          ) : (
            <span>
              Welcome, Guest!
            </span>
          )}
        </div>
        <a href="/users" style={styles.link}>Users</a>
        <a href="/channels" style={styles.link}>Channels</a>
        {currentUser ? (
          <a href={window.RailsPaths.logout} data-method="delete" style={styles.link}>Logout</a>
        ) : (
          <a href={window.RailsPaths.login} style={styles.link}>Login</a>
        )}
      </div>
    </nav>
  );
};

const styles = {
  nav: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    padding: "15px 40px",
    backgroundColor: "#1f1f1f",
    margin: 0,
    boxSizing: "border-box",
  },
  logo: {
    fontSize: "22px",
    fontWeight: "bold",
    marginTop: 0,
  },
  logoLink: {
    color: "#fff",
    textDecoration: "none",
    marginTop: 0,
  },
  links: {
    display: "flex",
    gap: "20px",
    color: "#fff",
  },
  link: {
    color: "#fff",
    textDecoration: "none",
    fontSize: "16px",
  },
};

export default Navbar;