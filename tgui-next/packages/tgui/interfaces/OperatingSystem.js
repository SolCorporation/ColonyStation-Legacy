import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, ColorBox, Section, Table } from '../components';


export const OperatingSystem = props => {
  const { act, data } = useBackend(props);
  const {
    programs = [],
    has_light,
    light_on,
    comp_light_color,
  } = data;
  return (
    <Fragment>
      <Section title="Programs">
        <Table>

        </Table>
      </Section>
    </Fragment>
  );
};
