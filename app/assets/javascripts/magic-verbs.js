/**
 * Magic for verb forms
 *
 * Created by maxim on 07.02.15.
 */

$(document).ready(function () {
    $('#verb-magic').on('click', function () {
        var infinitive   = $('#verb_infinitive').val();
        var long_chunk   = infinitive.slice(-5);
        var medium_chunk = infinitive.slice(-3);
        var short_chunk  = infinitive.slice(-2);

        var base, endings, ending, soften;

        if (long_chunk === 'овать') {
            base    = infinitive.slice(0, -5);
            endings = [
                'уй', 'уя', 'овав',
                'ую', 'уешь', 'ует', 'уем', 'уете', 'уют',
                'овал', 'овала', 'овало', 'овали'
            ];
        } else if (medium_chunk === 'ить') {
            base    = infinitive.slice(0, -3);
            ending  = base.slice(-1);
            soften  = !in_array(ending, ['ж', 'ш', 'ч', 'щ']);
            endings = [
                'и', soften ? 'я' : 'а', 'ив',
                soften ? 'ю' : 'у', 'ишь', 'ит', 'им', 'ите', soften ? 'ят' : 'ат',
                'ил', 'ила', 'ило', 'или'
            ];
        } else if (short_chunk === 'ть') {
            base    = infinitive.slice(0, -2);
            endings = [
                'й', 'я', 'в',
                'ю', 'ешь', 'ет', 'ем', 'ете', 'ют',
                'л', 'ла', 'ло', 'ли'
            ];
        } else if (short_chunk === 'чь') {
            base    = infinitive.slice(0, -2);
            endings = [
                'ки', 'ча', 'ча',
                'ку', 'чёшь', 'чёт', 'чём', 'чёте', 'кут',
                'к', 'кла', 'кло', 'кли'
            ];
        }

        if (endings) {
            $('#verb_imperative').val(base + endings[0]);
            $('#verb_gerund').val(base + endings[1]);
            $('#verb_gerund_past').val(base + endings[2]);
            $('#verb_present_first').val(base + endings[3]);
            $('#verb_present_second').val(base + endings[4]);
            $('#verb_present_third').val(base + endings[5]);
            $('#verb_present_first_plural').val(base + endings[6]);
            $('#verb_present_second_plural').val(base + endings[7]);
            $('#verb_present_third_plural').val(base + endings[8]);
            $('#verb_past_masculine').val(base + endings[9]);
            $('#verb_past_feminine').val(base + endings[10]);
            $('#verb_past_neuter').val(base + endings[11]);
            $('#verb_past_plural').val(base + endings[12]);
        }
    });

    $('#perfect-verb-magic').on('click', function () {
        var infinitive   = $('#perfect_verb_infinitive').val();
        var long_chunk   = infinitive.slice(-5);
        var medium_chunk = infinitive.slice(-3);
        var short_chunk  = infinitive.slice(-2);

        var base, endings, ending, soften;

        if (long_chunk === 'овать') {
            base    = infinitive.slice(0, -5);
            endings = [
                'уй', 'овав',
                'ую', 'уешь', 'ует', 'уем', 'уете', 'уют',
                'овал', 'овала', 'овало', 'овали',
                'ован', 'ована', 'овано', 'ованы'
            ];
        } else if (medium_chunk === 'ить') {
            base    = infinitive.slice(0, -3);
            ending  = base.slice(-1);
            soften  = !in_array(ending, ['ж', 'ш', 'ч', 'щ']);
            endings = [
                'и', 'ив',
                soften ? 'ю' : 'у', 'ишь', 'ит', 'им', 'ите', soften ? 'ят' : 'ат',
                'ил', 'ила', 'ило', 'или',
                'ит', 'ита', 'ито', 'иты'
            ];
        } else if (short_chunk === 'ть') {
            base    = infinitive.slice(0, -2);
            endings = [
                'й', 'в',
                'ю', 'ешь', 'ет', 'ем', 'ете', 'ют',
                'л', 'ла', 'ло', 'ли',
                'н', 'на', 'но', 'ны'
            ];
        } else if (short_chunk === 'чь') {
            base    = infinitive.slice(0, -2);
            endings = [
                'ки', 'ча',
                'ку', 'чёшь', 'чёт', 'чём', 'чёте', 'кут',
                'к', 'кла', 'кло', 'кли',
                'ён', 'ена', 'ено', 'ены'
            ];
        }

        if (endings) {
            $('#perfect_verb_imperative').val(base + endings[0]);
            $('#perfect_verb_gerund').val(base + endings[1]);
            $('#perfect_verb_future_first').val(base + endings[2]);
            $('#perfect_verb_future_second').val(base + endings[3]);
            $('#perfect_verb_future_third').val(base + endings[4]);
            $('#perfect_verb_future_first_plural').val(base + endings[5]);
            $('#perfect_verb_future_second_plural').val(base + endings[6]);
            $('#perfect_verb_future_third_plural').val(base + endings[7]);
            $('#perfect_verb_past_masculine').val(base + endings[8]);
            $('#perfect_verb_past_feminine').val(base + endings[9]);
            $('#perfect_verb_past_neuter').val(base + endings[10]);
            $('#perfect_verb_past_plural').val(base + endings[11]);
            $('#perfect_verb_passive_masculine').val(base + endings[12]);
            $('#perfect_verb_passive_feminine').val(base + endings[13]);
            $('#perfect_verb_passive_neuter').val(base + endings[14]);
            $('#perfect_verb_passive_plural').val(base + endings[15]);
        }
    });
});