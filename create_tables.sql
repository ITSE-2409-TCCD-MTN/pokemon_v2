DROP TABLE IF EXISTS regions, locations, types, type_effectiveness, abilities, moves, pokemon, evolutions, pokemon_type, pokemon_ability, pokemon_move, pokemon_location;

CREATE TABLE IF NOT EXISTS regions (
    id INTEGER PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS locations (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    region_id INTEGER REFERENCES regions(id)
);

CREATE TABLE IF NOT EXISTS types (
    id INTEGER PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS type_effectiveness(
    attacking_type_id INTEGER REFERENCES types(id),
    defending_type_id INTEGER REFERENCES types(id),
    damage_multiplier REAL,
    PRIMARY KEY (attacking_type_id, defending_type_id)
);

CREATE TABLE IF NOT EXISTS abilities (
    id INTEGER PRIMARY KEY,
    name VARCHAR(20),
    effect TEXT,
    short_effect TEXT,
    flavor_text TEXT
);

CREATE TABLE IF NOT EXISTS moves (
    id INTEGER PRIMARY KEY,
    name VARCHAR(20),
    power INTEGER,
    accuracy INTEGER,
    pp INTEGER,
    type_id INTEGER REFERENCES types(id),
    effect_chance INTEGER,
    damage_class VARCHAR(15),
    effect TEXT,
    flavor_text TEXT
);

CREATE TABLE IF NOT EXISTS pokemon(
    pokedex_number INTEGER PRIMARY KEY,
    name VARCHAR(20),
    hp INTEGER,
    attack INTEGER,
    defense INTEGER,
    sp_attack INTEGER,
    sp_defense INTEGER,
    speed INTEGER,
    height REAL,
    weight REAL,
    flavor_text TEXT
);

CREATE TABLE IF NOT EXISTS evolutions (
    evolved_pokedex_number INTEGER PRIMARY KEY REFERENCES pokemon(pokedex_number),
    base_pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
    min_level INTEGER,
    item_required VARCHAR(20),
    time_of_day VARCHAR(20),
    trade_required BOOLEAN
);

CREATE TABLE IF NOT EXISTS pokemon_type (
    pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
    type_id INTEGER REFERENCES types(id),
    slot INTEGER,
    PRIMARY KEY (pokedex_number, type_id)
);

CREATE TABLE IF NOT EXISTS pokemon_ability (
    pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
    ability_id INTEGER REFERENCES abilities(id),
    is_hidden BOOLEAN,
    slot INTEGER,
    PRIMARY KEY(pokedex_number, ability_id)
);

CREATE TABLE IF NOT EXISTS pokemon_move (
    pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
    move_id INTEGER REFERENCES moves(id),
    learn_method VARCHAR(25),
    level_learned_at INTEGER,
    PRIMARY KEY(pokedex_number, move_id)
);

CREATE TABLE IF NOT EXISTS pokemon_location(
    pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
    location_id INTEGER REFERENCES locations(id),
    PRIMARY KEY(pokedex_number, location_id)
);
