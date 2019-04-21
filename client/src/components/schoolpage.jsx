import React, {Component} from "react";
import "./schoolpage.css";
import {NavLink} from "react-router-dom";

export default class SchoolPage extends Component{
    render(){
        return(
            <div className="sp-body1">
                <div id="header3">
                    <span className="rescript">Rescript</span>
                    <span className="dashboard">Student Dashboard</span>
                    <NavLink to="/"><span className="logout">Log out</span></NavLink>
                </div>
                <iframe src="/background" frameBorder="0" className="frame" name="iframe" title="iframebody"></iframe>
                <div className="left-drawer">
                    <div className="dwr">
                        <NavLink to="#"><p>Requests /</p></NavLink>
                        <NavLink to="#"><p>Received</p></NavLink>
                    </div>
                    <div className="otherframe">
                            <NavLink to="/account" target="iframe"><p>54387736</p></NavLink>
                            <NavLink to="#"><p>86368865</p></NavLink>
                            <NavLink to="#"><p>67673425</p></NavLink>
                    </div>
                </div>
            </div>
        );
    }
}