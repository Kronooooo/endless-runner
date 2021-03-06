# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v0.1.0] - 2021-04-22
### Added
 - basic movement for the player, including moving left, moving right, and jumping
 - walls
 - temporary sprites for the walls and player
 - test world

## [v0.1.1] - 2021-04-24
### Added
 - changelog
 - lava with temporary sprite
 - when the player collides with the lava the game is reset

### Changed
 - test world to include lava

## [v0.1.2] - 2021-04-24
### Added
 - basic level generation

## [v0.1.3] - 2021-04-25
### Added
 - endless level generation
 - new level
 - checkpoint block which generates the next part of the map

### Changed
 - player hitbox
 - probability of lava spawning

## [v0.1.4] - 2021-04-26
### Added
 - keys
 - doors

### Changed
 - max number of lava blocks spawning consecutively (7 -> 6)