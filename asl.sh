#!/bin/bash
# asl
v="1.0"

sl=("male" "female" "m" "f") # needs more gay shit
ll=(
    # the united states
    "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" 
"Delaware"
    "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas"
    "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" 
"Mississippi"
    "Missouri" "Montana" "Nebraska" "Nevada" "New Hampshire" "New Jersey" "New Mexco" 
"New York"
    "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "Rhode 
Island" "South Carolina"
    "South Dakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "West 
Virginia"
    "Wisconsin" "Wyoming"
    # canadian territories and provinces
    "Ontario" "Quebec" "Nova Scotia" "New Brunswick" "Manitoba" "British Columbia" 
"Prince Edward Island" "Saskatchewan"
    "Alberta" "Newfoundland and Labrador"
    # countries
    "Afghanistan" "Albania" "Algeria" "Andorra" "Argentina" "Armenia"  "Australia" 
"Austria"
    "Azerbaijan" "Bahamas" "Bahrain" "Bangladesh" "Barbados" "Belarus" "Belgium" 
"Belize"
    "Benin" "Bhutan" "Bolivia" "Botswana" "Brazil" "Brunei" "Bulgaria" "Burma"
    "Burundi" "Cambodia" "Cameroon" "Chad" "Chile" "China" "Colombia" "Comoros" 
"Costa Rica"
    "Croatia" "Cuba" "Cyprus" "Czech Republic" "Denmark" "Djibouti" "Dominica" 
"Dominican Republic"
    "East Timor" "Ecuador" "Egypt" "El Salvador" "Equitorial Guinea" "Eritrea" 
"Estonia" "Ethiopia"
    "Fiji" "Finland" "France" "Gabon" "Gambia" "Germany" "Ghana" # Georgia
    "Greece" "Grenada" "Guatemala" "Guinea" "Guyana" "Haiti" "Honduras" "Hungary"
    "Iceland" "India" "Indonesia" "Iran" "Iraq" "Ireland" "Israel" "Italy"
    "Ivory Coast" "Jamaica" "Japan" "Jordan" "Kazakhstan" "Kenya" "Kiribati" "North 
Korea"
    "South Korea" "Kuwait" "Kyrgyzstan" "Laos" "Latvia" "Lebanon" "Lesotho" "Liberia"
    "Libya" "Liechtenstein" "Lithuania" "Luxembourg" "Macedonia" "Madagascar" 
"Malawi" "Malaysia"
    "Maldives" "Mali" "Malta" "Marshall Islands" "Mauritania" "Mauritius" "Mexico" 
"Micronesia"
    "Moldova" "Monaco" "Mongolia" "Montenegro" "Morocco" "Mozambique" "Namibia" 
"Nauru"
    "Nepal" "Netherlands" "New Zealand" "Nicaragua" "Niger" "Nigeria" "Norway" "Oman"
    "Pakistan" "Palau" "Palestine" "Panama" "Papua New Guinea" "Paraguay" "Peru" 
"Philippines"
    "Poland" "Portugal" "Qatar" "Romania" "Russia" "Rwanda" "Saint Lucia" "Samoa"
    "San Marino" "Saudi Arabia" "Senegal" "Serbia" "Seychelles" "Sierra Leone" 
"Singapore" "Slovakia"
    "Slovenia" "Solomon Islands" "Somalia" "South Africa" "South Sudan" "Spain" "Sri 
Lanka" "Sudan"
    "Suriname" "Swaziland" "Sweden" "Switzerland" "Syria" "Tajikistan" "Tanzania" 
"Thailand"
    "Togo" "Tonga" "Tunisia" "Turkey" "Turkmenistan" "Tuvalu" "Uganda" "Ukraine"
    "U.K." "Uruguay" "Uzbekistan" "Vanuatu" "Vatican City" "Venezuela" "Vietnam" 
"Yemen"
    "Zambia" "Zimbabwe"
    # fictional locations ## TODO ##
    "Narnia" "Tatooine"
)
while getopts "hvn:" opt; do
	case "${opt}" in
		v)
			echo "asl version $v"
			exit 0 ;;
		h)
			echo "asl -v -h -?? -n [number]"
			echo "-v version"
			echo "-h help"
			echo "-n number of iterations"
			exit 0 ;;
		n)
			i=0
			while [ $i -lt ${OPTARG} ]; do
				a=$(( $RANDOM % 99 ))
				s=${sl[$RANDOM % ${#sl[@]} ]}
				l=${ll[$RANDOM % ${#ll[@]} ]}
				echo $a/$s/$l
				((i++))
			done
			exit 0 ;;
	esac
done
a=$(( $RANDOM % 99 ))
s=${sl[$RANDOM % ${#sl[@]} ]}
l=${ll[$RANDOM % ${#ll[@]} ]}
echo $a/$s/$l

