import React from "react";
import {Link} from "react-router-dom";

export default function Header() {
    return (
        <header className="main-header">
            <nav>
                <ul>
                    <li><Link to="/">Inglip</Link></li>
                    <li><Link to="/about">О проекте</Link></li>
                    <li><Link to="/chat">Чат</Link></li>
                </ul>
            </nav>
        </header>
    )
}
