import { Fragment } from 'inferno';
import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Button, Section, ProgressBar, NoticeBox, NumberInput } from '../components';

export const FuelMixer = props => {
  const { act, data } = useBackend(props);

  return (
    <Section>
      {data.mix && (
        <Fragment>
          <Section title="Fuel Mixer">
            <b>Deuterium Mix:</b>
            <ProgressBar maxValue={100} value={data.deu} content={Math.round(data.deu) + "%"} />
            <br /><br />
          Set Deuterium Mix to <br />
            <NumberInput minValue={0} value={data.deu} width="75px" unit="%" maxValue={100}
              onChange={(e, value) => act('deu_change', {
                added: value,
              })} />
            <br /><br />
            <b>Tritium Mix:</b>
            <ProgressBar maxValue={100} value={data.tri} content={Math.round(data.tri) + "%"} />
            <br /><br />
          Set Tritium Mix to <br />
            <NumberInput minValue={0} value={data.tri} width="75px" unit="%" maxValue={100}
              onChange={(e, value) => act('trit_change', {
                added: value,
              })} />
            <br /><br />
            <Button inline icon="cog"
              content="Eject Mix Disk"
              onClick={() => act('eject')} />
          </Section>
          <Section title="Fuel Statistics">
            <b>Available Additives</b>
            <br />
            {map((value, key) => (
              <Section><b>{value.aName}</b>
                <br />
                {value.aDesc}
                <br />
                <Button inline icon="plus"
                  content="Add Additive"
                  onClick={() => act('add', { additive: value.aName })} />
              </Section>
            ))(data.possibleAdditives)}
            <br /><br />
            <b>Added Additives</b>
            <br />
            {map((value, key) => (
              <Section><b>{value.aName}</b>
                <br />
                {value.aDesc}
                <br />
                <Button inline icon="minus"
                  content="Remove Additive"
                  onClick={() => act('remove', { additive: value.aName })} />
              </Section>
            ))(data.additives)}
          </Section>
        </Fragment>
      ) || (
        <NoticeBox>
          <h3>No mix inserted</h3>
        </NoticeBox>
      )}
    </Section>
  );
};
