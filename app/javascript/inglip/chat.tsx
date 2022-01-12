import React, {useState} from "react";
import {useTrigram} from "./hooks/use_ngram";

export default function Chat() {
    const [message, setMessage] = useState('')
    const [messages, setMessages] = useState([])
    const [grams, feed] = useTrigram()

    function handleSubmit(event) {
        event.preventDefault()
        setMessages(prevMessages => prevMessages.concat([message]))
        feed(message)
        setMessage('')
    }

    function handleChange(event) {
        setMessage(event.target.value)
    }

    return (
        <section>
            <h1>Chat</h1>
            <section className="chat-messages">
                <ul>{messages.map((m, i) => <li key={i}>{m}</li>)}</ul>
            </section>
            <form onSubmit={handleSubmit}>
                <div>
                    <textarea value={message} onChange={handleChange}/>
                </div>
                <div>
                    <button>Отправить</button>
                </div>
            </form>
            <table>
                <thead>
                <tr>
                    <th>ТГ</th>
                    <th>Вес</th>
                </tr>
                </thead>
                <tbody>
                {Object.entries(grams).map(v => (
                    <tr key={v[0]}>
                        <th>{v[0]}</th>
                        <td>{v[1]}</td>
                    </tr>
                ))}
                </tbody>
            </table>
        </section>
    )
}
