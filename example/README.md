# blemulator_example

Demonstrates how to use the blemulator plugin.

## UI structure

App consists of two screens: `PeripheralListScreen` and 
`PeripheralDetailsScreen`.

Skeleton UI flow:

![](./images/ui-flow.gif)

### `PeripheralListScreen`

`PeripheralListScreen` combines two features:
- control of scan process (start / stop), which is represented by a 
button in the AppBar,
- list of scanned peripherals, which takes the main space on the 
screen.

Scanned peripherals are represented in a list. Each peripheral row 
contains:
- peripheral icon based on peripheral category,
- peripheral identifier,
- peripheral name,
- rssi value with appropriate icon and color depending on signal 
strength.

Peripheral category determines the color of icon view and identifier
text view.

When peripheral row is tapped, application transitions to the 
`PeripheralDetailsScreen`.

### `PeripheralDetailsScreen`

`PeripheralDetailsScreen` displays more detailed information regarding 
given peripheral.
More specific information is available depending on the peripheral's 
connection state.

#### `PeripheralDetailsScreen` layout

For development purposes it was decided that main layout of details
screen is going to be created differently based on the peripheral 
category:

**Base details view** - for most of peripherals

**Tabbed layout with 3 tabs** - for SensorTag peripherals (primary peripheral
used during development):
1. Base details view (exactly the same as for all other peripherals)
2. Automated test view
3. Manual test view

##### Base details view

Base details view is a scrollable view that contains specific sections:

1. General peripheral information: identifier, connect / disconnect button
2. Rssi section: most recent rssi value
3. MTU section: MTU value with value
4. Services / Characteristics section: presenting the list of discovered 
services and characteristics

Services are presented as a list of expandable items. Each ServiceItem
contains:
- service identifier,
- expand/collapse handle button. 

When ServiceItem
is expanded, list of Characteristics associated with that item is presented
as well.

Each CharacteristicItem contains:
- characteristic identifier,
- characteristic value,
- characteristic properties (isReadableWithResponse, isReadableWithoutResponse,
isNotifiable, isIndicatable),
- characteristic operation buttons: Read, Write, Monitor 
(which are available depending on properties).

Pressing Read, Write, Monitor buttons results in an appropriate action:
- Read - value of characteristic is refreshed,
- Write - dialog with appropriate fields needed to write to characterstic
is displayed.
- Monitor - value of characteristic is monitored (value should be refreshed
each time there is an update).

##### Automated test view

View from original example created for automated peripheral test written 
for SensorTag.

##### Manual test view

View from original example created for manual test operations written
for SensorTag.
