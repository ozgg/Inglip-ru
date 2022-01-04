import * as React from "react";
import {Route, Routes} from "react-router-dom"
import Header from "./layout/header";
import Footer from "./layout/footer";
import About from "./inglip/about";
import Home from "./inglip/home";
import Chat from "./inglip/chat";

export default function Inglip() {
    return (
        <>
            <Header/>
            <main>
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="/about" element={<About />} />
                    <Route path="/chat" element={<Chat />}/>
                </Routes>
            </main>
            <Footer/>
        </>
    )
}
