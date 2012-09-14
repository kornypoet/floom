# Floom

A small set of Ruby tools to make using Apache Flume a little less painful.

## Usage

Floom ships with several command line utilities that shorten lengthy, often-used Flume commands.

`floom oneshot <flume config string>`

Executes a no watchdog, no heartbeat, exit on failure Flume node with the supplied config.

`floom debug <decorator file>`

Executes a oneshot node with a console source, and a console sink decorated with the definition supplied.
