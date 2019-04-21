import React, {Component} from "react";
import "./studentlogin.css";
import {NavLink} from "react-router-dom";

export default class StudentLogin extends Component{
    render(){
        return(
            <div id="main">
                <div className="blacky">
                    <div id="header">
                        Rescript
                    </div>
                    <div className="loginInput">
                        <div className="theTitle">Student Log In</div>
                        <input type="email" placeholder="E-mail address"/>
                        <input type="password" placeholder="Password"/>
                        <NavLink to="/studentpage">
                            <div className="button">
                                Log in
                            </div>
                        </NavLink>
                    </div>
                    
                </div>
            </div>
        );
    }
}