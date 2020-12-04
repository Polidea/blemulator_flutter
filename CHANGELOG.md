## 1.2.1

* Fix crash on iOS when manufacturer's data was present in the advertising packet

## 1.2.0

* Add support for connecting to peripheral without launching scan first

## 1.1.3

* Fix incorrect iOS plugin class name causing `Duplicate plugin key: FlutterBleLib`

## 1.1.2

* Unify internal representation of UUIDs to lower case, making simulated GATTs case insensitive

## 1.1.1

* hide private API
* remove unnecessary log
* update dependencies

## 1.1.0

* **NEW** characteristics may now contain descriptors

## 1.0.1

* Fix an issue causing characteristics' properties to be null on iOS

## 1.0.0
First release of BLEmulator for Flutter!

BLEmulator supports:
* switching simulation on
* peripherals (manipulation of advertisement data and interval, connection, discovery)
* services (fetching characteristics)
* characteristics (reading, writing, notifications/indications)
