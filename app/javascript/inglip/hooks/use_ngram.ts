import {useState} from "react";

export function useTrigram() {
    return useNgram(3)
}

export default function useNgram(n: number = 3) {
    if (typeof n !== 'number' || Number.isNaN(n) || n < 1 || n > 10) {
        throw new Error('`' + n + '` is not a valid argument for `useNgram`')
    }

    const [data, setData] = useState({})

    const feed = (input: string) => {
        const list: string[] = []
        let index = input.length - n + 1

        if (index < 1) {
            return
        }

        while (index--) {
            list[index] = input.slice(index, index + n)
        }

        setData(prev => {
            const data = {...prev}
            for (let gram of list) {
                data[gram] = data.hasOwnProperty(gram) ? data[gram] + 1 : 1
            }

            return data
        })
    }

    return [data, feed]
}
