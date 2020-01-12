import { Fragment } from 'inferno';
import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Button, LabeledList, Section, Tabs, Box, NoticeBox, Grid, ProgressBar } from '../components';

export const FusionController = props => {
  const { act, data } = useBackend(props);

  return (
    <Fragment>
      <Section title="Reactor Controls">
        {!!data.meltDown && (<NoticeBox><h2>CORE MELTDOWN - REWELD CONTAINMENT CHAMBER</h2></NoticeBox>)}
        {!!data.overheating && (<NoticeBox><h2>CORE OVERHEATING</h2></NoticeBox>)}
        <br />
        <b>Current Reactor Status:</b> {data.status}
        <br /><br />
        <b>Reactor Deuterium Status:</b>
        <ProgressBar color={data.deuterium >= 50 ? ("good") : ("average")}
        maxValue={100} value={data.deuterium} content={Math.round(data.deuterium) + "%"} />
        <br /><br />
        <b>Reactor Tritium Status:</b>
        <ProgressBar color={data.tritium >= 50 ? ("good") : ("average")}
        maxValue={100} value={data.tritium} content={Math.round(data.tritium) + "%"} />
        <br /><br /><br /><br />
        <Button inline icon={!!data.injecting && ("stop") || ("play")}
          content={!!data.injecting && ("Stop Fuel Injection") || ("Begin Fuel Injection")}
          onClick={() => act('toggleInject')}
          selected={!!data.injecting} />
      </Section>
    </Fragment>
  );
};
