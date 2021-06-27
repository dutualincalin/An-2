# Design Patterns lab part 2: Command

Design a mock application for creating and editing diagrams, using the Command pattern.

The pattern is used to encapsulate actions related to editing diagram components into objects. The drawing commands
will be executed by an Invoker, a middleware between the Client that gives the commands and their receiver, diagram
objects.

## Components

DiagramCanvas
- represents the diagram
- consists of DiagramComponents
- is the receiver in the CommandPattern

DiagramComponent
- represents a component such as a square in a diagram
- for simplicity we will not have subtypes for it
- the commands modify it

DrawCommand
- it is an interface implemented by all the commands
- the commands represent actions that can be performed on the canvas or its components

Invoker
- receives commands and executes them, it decoupled from the implementations of the commands
- supports an undo/redo mechanism

Client
- creates commands and passes them to the Invoker

Test
- entry-point
- contains several scenarios for testing commands
- uses the Client






