config = {}

-- Model name of the extinguishers
config.extinguisherName = "Extinguishers"

config.locations = {
    -- Mission Row PD
    vector4(454.45, -993.28, 30.69, 358.61),  -- Locker room
    vector4(453.54, -985.1, 30.69, 183.04), -- Locker room hallway
    vector4(445.07, -976.79, 30.69, 95.19), -- Font Lobby behind desk
    vector4(436.31, -988.02, 30.69, 354.34), -- Front Lobby Public
    vector4(450.08, -977.61, 30.69, 357.62), -- Captains Office
    vector4(450.72, -978.53, 30.69, 180.86), -- Armoury Front
    vector4(437.99, -990.06, 30.69, 174.9), -- Meeting room
    vector4(454.56, -984.28, 26.67, 186.06), -- Cells corridoor
    vector4(459.81, -991.8, 24.91, 270.45), -- Cells
    vector4(462.25, -1008.45, 25.56, 269.64), -- Cells backdoor
    vector4(463.93, -985.29, 43.69, 90.36), -- Roof

    -- Sandy PD
    vector4(1855.98, 3684.6, 34.27, 38.33), -- Public Lobby
    vector4(1852.83, 3691.94, 34.27, 124.83), -- Lobby Desk Behind

    -- Paleto PD
    vector4(-451.07, 6011.64, 31.72, 224.28), -- Lobby Desk Behind

    -- Sandy Gas Station
    vector4(2004.94, 3781.91, 32.18, 208.33),

    -- Paleto Bank
    vector4(-118.35, 6469.88, 31.63, 228.36), -- Front lobby
    vector4(-102.35, 6471.88, 31.63, 131.28), -- Vault door

    -- Zancudo Military Base 
    vector4(-2352.72, 3249.67, 101.45, 68.17), -- ATC Room Top
    vector4(-2358.61, 3257.27, 92.9, 238.72), -- ATC Server Room
    vector4(-2358.51, 3246.27, 92.9, 150.6), -- ATC Room Lower
    vector4(-2359.67, 3253.78, 32.81, 238.32), -- ATC Ground Floor Elivator
    vector4(-2348.95, 3256.92, 32.81, 63.01), -- ATC Ground Floor Corridoor
    vector4(-2342.61, 3268.25, 32.81, 150.22), -- ATC Ground Floor Front Door

    -- David FD
    vector4(212.5, -1654.49, 29.8, 48), -- Bays

    -- El Burro Heights FD
    vector4(1207.94, -1471.23, 34.86, 92.36)
}

config.types = {
    "Water",
    "Foam"
}