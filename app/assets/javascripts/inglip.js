'use strict';

const Inglip = {
    lexemeForm: {
        infinitive: undefined,
        initialize() {
            this.infinitive = document.getElementById('lexeme_body');
            if (this.infinitive) {
                Inglip.nounForm.initialize();
                Inglip.adjectiveForm.initialize();
                Inglip.adverbForm.initialize();
            }
        },
        hide(item) {
            item.classList.add('hidden');
            item.querySelectorAll('input').forEach((f) => f.value = '');
        },
        show(item) {
            item.classList.remove('hidden');
        },
        checkState(flag, list) {
            if (flag) {
                const callback = flag.checked ? this.show : this.hide;

                list.forEach((item) => callback(item));
            }
        },
        applyMapping(mapping) {
            mapping.forEach(function (pair) {
                const flag = document.getElementById(pair[0]);
                const lists = pair[1].map((selector) => document.querySelectorAll(selector));

                lists.forEach((list) => Inglip.lexemeForm.checkState(flag, list));

                if (flag) {
                    flag.addEventListener('change', function () {
                        lists.forEach((list) => Inglip.lexemeForm.checkState(flag, list));
                    });
                }
            });
        }
    },
    initialize() {
        this.lexemeForm.initialize();
    }
};

Inglip.nounForm = {
    mapping: [
        ['lexeme_flag_has_partitive', ['li.case_partitive']],
        ['lexeme_flag_has_locative', ['li.case_locative']],
        ['lexeme_flag_singular_form', ['div.number_singular']],
        ['lexeme_flag_plural_form', ['div.number_plural']],
    ],
    magicButton: undefined,
    initialize() {
        this.magicButton = document.getElementById('noun-magic');
        if (this.magicButton) {
            Inglip.lexemeForm.applyMapping(this.mapping);
            this.magicButton.addEventListener('click', Inglip.nounForm.performMagic);
        }
    },
    performMagic() {
        const infinitive = Inglip.lexemeForm.infinitive;
        if (infinitive.value === '') {
            infinitive.focus();
            return;
        }

        const declinable = document.getElementById('lexeme_declinable').checked;
        if (!declinable) {
            document.querySelectorAll('#wordforms input').forEach(function (field) {
                if (field.value === '') {
                    field.value = infinitive.value;
                }
            });
            return;
        }

        const animated = document.getElementById('lexeme_flag_animated').checked;

        let gender = '';
        if (document.getElementById('lexeme_flag_gender_masculine').checked) {
            gender = 'm';
        } else if (document.getElementById('lexeme_flag_gender_feminine').checked) {
            gender = 'f'
        } else if (document.getElementById('lexeme_flag_gender_neuter').checked) {
            gender = 'n';
        }

        const ending = infinitive.value.slice(-1);
        const penultimate = infinitive.value.slice(-2).substring(0, 1);
        const sibilant = ['ж', 'ш', 'щ', 'ч', 'ц'].includes(penultimate);
        let soften = ['г', 'к', 'ш', 'ж'].includes(penultimate);

        let root, endings, plurals;

        if (gender === 'm') {
            switch (ending) {
                case 'а':
                    soften |= sibilant;
                    root = infinitive.value.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', animated ? 'у' : ending, 'ой', 'е'];
                    plurals = [soften ? 'и' : 'ы', '', 'ам', animated ? '' : (soften ? 'и' : 'ы'), 'ами', 'ах'];
                    break;
                case 'я':
                    root = infinitive.value.slice(0, -1);
                    endings = ['и', 'е', animated ? 'ю' : ending, 'ей', 'е'];
                    plurals = ['и', 'ь', 'ям', animated ? 'ей' : 'и', 'ями', 'ях'];
                    break;
                case 'ь':
                    root = infinitive.value.slice(0, -1);
                    endings = ['я', 'ю', animated ? 'я' : ending, 'ем', 'е'];
                    plurals = ['и', 'ей', 'ям', animated ? 'ей' : 'и', 'ями', 'ях'];
                    break;
                case 'о':
                    root = infinitive.value.slice(0, -1);
                    endings = ['и', 'е', animated ? 'ю' : ending, 'ой', 'е'];
                    plurals = ['и', 'ек', 'ам', animated ? 'ек' : 'и', 'ами', 'ах'];
                    break;
                case 'е':
                    root = infinitive.value.slice(0, -1);
                    soften = !['ч', 'щ'].includes(root.slice(-1));
                    endings = [soften ? 'я' : 'а', soften ? 'ю' : 'у', animated ? 'а' : ending, 'ем', 'е'];
                    plurals = [sibilant ? 'и' : 'ы', '', sibilant ? 'ям' : 'ам', animated ? 'ей' : (sibilant ? 'и' : 'ы'), 'ами', 'ах'];
                    break;
                case 'щ':
                    root = infinitive.value;
                    endings = ['а', 'у', animated ? 'а' : '', 'ом', 'е'];
                    plurals = ['и', 'ей', 'ам', animated ? 'ей' : 'и', 'ами', 'ах'];
                    break;
                case 'й':
                    root = infinitive.value.slice(0, -1);
                    endings = ['я', 'ю', animated ? 'я' : ending, 'ем', 'е'];
                    plurals = ['и', 'ев', 'ям', animated ? 'ев' : 'и', 'ями', 'ях'];
                    break;
                default:
                    if ((ending === 'к') && ['о', 'ё'].includes(penultimate)) {
                        root = infinitive.value.slice(0, -2);
                        if (penultimate === 'ё') {
                            root += 'ь';
                        }
                        endings = ['ка', 'ку', animated ? 'ка' : (penultimate + 'к'), 'ком', 'ке'];
                        plurals = ['ки', 'ков', 'кам', animated ? 'ков' : 'ки', 'ками', 'ках'];
                    } else if (ending === 'н' && penultimate === 'и' && animated) {
                        root = infinitive.value.slice(0, -2);
                        endings = ['на', 'ну', 'на', 'ном', 'не'];
                        plurals = ['е', '', 'ам', '', 'ами', 'ах'];
                    } else {
                        soften = ['г', 'к'].includes(ending);
                        root = infinitive.value;
                        endings = ['а', 'у', animated ? 'а' : '', 'ом', 'е'];
                        plurals = [soften ? 'и' : 'ы', 'ов', 'ам', animated ? 'ов' : (soften ? 'и' : 'ы'), 'ами', 'ах'];
                    }
                    break;
            }
        } else if (gender === 'f') {
            switch (ending) {
                case 'а':
                    root = infinitive.value.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', 'у', sibilant ? 'ей' : 'ой', 'е'];
                    plurals = [soften ? 'и' : 'ы', '', 'ам', animated ? '' : (soften ? 'и' : 'ы'), 'ами', 'ах'];
                    break;
                case 'я':
                    root = infinitive.value.slice(0, -1);
                    endings = ['и', 'е', 'ю', 'ей', 'е'];
                    plurals = ['и', 'ь', 'ям', animated ? 'ь' : 'и', 'ями', 'ях'];
                    break;
                case 'ь':
                    soften = !in_array(penultimate, ['ж', 'ш', 'щ', 'ч']);
                    root = infinitive.value.slice(0, -1);
                    endings = ['и', 'и', ending, ending + 'ю', 'и'];
                    plurals = ['и', 'ей', soften ? 'ям' : 'ам', animated ? 'ей' : 'и', soften ? 'ями' : 'ами', soften ? 'ях' : 'ах'];
                    break;
                default:
                    root = infinitive.value;
                    endings = ['', '', '', '', ''];
                    plurals = ['', '', '', animated ? '' : '', '', ''];
                    break;
            }
        } else if (gender === 'n') {
            switch (ending) {
                case 'о':
                    root = infinitive.value.slice(0, -1);
                    endings = ['а', 'у', ending, 'ом', 'е'];
                    plurals = ['а', '', 'ам', animated ? '' : 'а', 'ами', 'ах'];
                    break;
                case 'е':
                    root = infinitive.value.slice(0, -1);
                    soften = !['ч', 'щ', 'ж', 'ш'].includes(penultimate);
                    endings = [soften ? 'я' : 'а', soften ? 'ю' : 'у', ending, 'ем', 'е'];
                    if (penultimate === 'и') {
                        endings[5] = 'и';
                        plurals = ['я', 'й', 'ям', animated ? 'й' : 'я', 'ями', 'ях'];
                    } else {
                        plurals = [soften ? 'я' : 'а', 'ей', soften ? 'ям' : 'ам', animated ? 'ей' : (soften ? 'я' : 'а'), soften ? 'ями' : 'ами', soften ? 'ях' : 'ах'];
                    }
                    break;
                case 'я':
                    root = infinitive.value.slice(0, -1);
                    endings = ['ени', 'еню', 'я', 'енем', 'ени'];
                    plurals = ['ена', 'ян', 'енам', animated ? 'ян' : 'ена', 'енами', 'енах'];
                    break;
                default:
                    root = infinitive.value;
                    endings = ['', '', '', '', ''];
                    plurals = ['', '', '', animated ? '' : '', '', ''];
                    break;
            }
        } else {
            root = infinitive.value;
            endings = ['', '', '', '', ''];
            plurals = ['', '', '', '', '', ''];
        }

        document.getElementById('wordform-number_singular-case_nominative').value = infinitive.value;

        const mapping = {
            "singular": {
                "genitive": root + endings[0],
                "partitive": root + endings[0],
                "dative": root + endings[1],
                "accusative": root + endings[2],
                "instrumental": root + endings[3],
                "prepositional": root + endings[4],
                "locative": root + endings[4]
            },
            "plural": {
                "nominative": root + plurals[0],
                "genitive": root + plurals[1],
                "partitive": root + plurals[1],
                "dative": root + plurals[2],
                "accusative": root + plurals[3],
                "instrumental": root + plurals[4],
                "prepositional": root + plurals[5],
                "locative": root + plurals[5],
            }
        };

        for (let number in mapping) {
            if (mapping.hasOwnProperty(number)) {
                for (let grammatical_case in mapping[number]) {
                    if (mapping[number].hasOwnProperty(grammatical_case)) {
                        const id = `wordform-number_${number}-case_${grammatical_case}`;
                        const element = document.getElementById(id);
                        const parent = element.closest('li');

                        if (parent.classList.contains('hidden')) {
                            element.value = '';
                        } else {
                            element.value = mapping[number][grammatical_case];
                        }
                    }
                }
            }
        }
    }
};

Inglip.adjectiveForm = {
    flags: {
        qualitative: undefined,
        superlative: undefined,
    },
    comparative_degree: undefined,
    mapping: [
        ['lexeme_flag_qualitative', ['li.short_form', 'li.degree_superlative', 'div.qualitative']]
    ],
    magicButton: undefined,
    initialize() {
        this.magicButton = document.getElementById('adjective-magic');
        if (this.magicButton) {
            Inglip.lexemeForm.applyMapping(this.mapping);
            this.flags.qualitative = document.getElementById('lexeme_flag_qualitative');
            this.flags.superlative = document.getElementById('lexeme_flag_superlative');
            this.comparative_degree = document.getElementById('wordform-degree_comparative');
            this.magicButton.addEventListener('click', Inglip.adjectiveForm.performMagic);
        }
    },
    performMagic() {
        const infinitive = Inglip.lexemeForm.infinitive;

        if (infinitive.value === '') {
            infinitive.focus();
            return;
        }

        let qualitative, superlative;
        if (Inglip.adjectiveForm.flags.qualitative) {
            qualitative = Inglip.adjectiveForm.flags.qualitative.checked;
        } else {
            qualitative = false;
        }
        if (Inglip.adjectiveForm.flags.superlative) {
            superlative = Inglip.adjectiveForm.flags.superlative.checked;
        } else {
            superlative = false;
        }
        const base        = infinitive.value.slice(0, -2);
        const penultimate = infinitive.value.slice(-2).substr(0, 1);
        let soften;
        if (['к', 'г', 'ж', 'ш'].includes(base.slice(-1), )) {
            soften = false;
        } else {
            soften = (penultimate === 'и');
        }

        const m = soften ? 'е' : 'о'; // Masculine
        const f = soften ? 'я' : 'а'; // Feminine
        const n = soften ? 'е' : 'о'; // Neuter
        const p = soften ? 'и' : 'ы'; // Plural
        const i = (penultimate === 'о' ? 'ы' : penultimate); // Instrumental case

        let form, ending;
        const endings = {
            "gender_masculine": [infinitive.value.slice(-2), m + 'го', m + 'му', m + 'го', i + 'м', m + 'м', ''],
            "gender_feminine": [f + 'я', m + 'й', m + 'й', (soften ? 'ю' : 'у') + 'ю', m + 'й', m + 'й', 'a'],
            "gender_neuter": [n + 'е', n + 'го', n + 'му', n + 'го', i + 'м', n + 'м', 'о'],
            "number_plural": [p + 'е', p + 'х', p + 'м', p + 'х', p + 'ми', p + 'х', penultimate]
        };

        console.log(qualitative, superlative);
        if (qualitative && !superlative) {
            let short_form;

            Inglip.adjectiveForm.comparative_degree.value = base + 'ее';
            for (form in endings) {
                if (endings.hasOwnProperty(form)) {
                    short_form = document.getElementById(`wordform-${form}-short_form`);
                    if (short_form && !short_form.closest('li').classList.contains('hidden')) {
                        short_form.value = base + endings[form][6];
                    }
                }
            }
        }

        const cases = ['nominative', 'genitive', 'dative', 'accusative', 'instrumental', 'prepositional'];
        let case_index, field_id;

        for (form in endings) {
            if (endings.hasOwnProperty(form)) {
                ending = endings[form];
                for (case_index in cases) {
                    if (cases.hasOwnProperty(case_index)) {
                        field_id = `wordform-${form}-case_${cases[case_index]}`;
                        document.getElementById(field_id).value = base + ending[case_index];
                    }
                }
            }
        }
    }
};

Inglip.adverbForm = {
    flags: {
        qualitative: undefined,
        adjunct: undefined,
        attributive: undefined
    },
    comparative_degree: undefined,
    superlative_degree: undefined,
    mapping: [
        ['lexeme_flag_qualitative', ['div.qualitative']]
    ],
    magicButton: undefined,
    initialize() {
        this.magicButton = document.getElementById('adverb-magic');
        if (this.magicButton) {
            Inglip.lexemeForm.applyMapping(this.mapping);
            this.flags.qualitative = document.getElementById('lexeme_flag_qualitative');
            this.flags.adjunct = document.getElementById('lexeme_flag_adjunct');
            this.flags.attributive = document.getElementById('lexeme_flag_attributive');
            this.comparative_degree = document.getElementById('wordform-degree_comparative');
            this.superlative_degree = document.getElementById('wordform-degree_superlative');
            this.magicButton.addEventListener('click', Inglip.adverbForm.performMagic);
        }
    },
    performMagic() {
        // Not implemented
    }
};

document.addEventListener('DOMContentLoaded', function () {
    Inglip.initialize();
});
