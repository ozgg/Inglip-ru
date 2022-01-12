import React, {useState} from "react";

export default function Chat() {
    const [message, setMessage] = useState('')
    const [messages, setMessages] = useState([])

    function handleSubmit(event) {
        event.preventDefault()
        setMessages(prevMessages => prevMessages.concat([message]))
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
        </section>
    )
}
