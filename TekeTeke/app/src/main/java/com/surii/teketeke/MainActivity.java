package com.surii.teketeke;

import android.app.Dialog;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.os.Bundle;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.internal.GoogleServices;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import com.surii.teketeke.adapter.PlaceAutoSuggestAdapter;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.util.JsonReader;
import android.util.JsonWriter;
import android.util.Log;
import android.view.View;

import android.view.Menu;
import android.view.MenuItem;
import android.widget.AdapterView;
import android.widget.AutoCompleteTextView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Scanner;

public class MainActivity extends AppCompatActivity {
private   TextView textViewto, textViewfrom;
private Dialog errorDialog;
    private  AutoCompleteTextView from,to;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
         from = findViewById(R.id.from);
        to = findViewById(R.id.to);
        PlayServicesUpdate();
        from.setAdapter(new PlaceAutoSuggestAdapter(MainActivity.this, android.R.layout.simple_list_item_1));

        from.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Log.d("Address : ", from.getText().toString());
                LatLng latLngfrom = getLatLngFromAddress(from.getText().toString());
                if (latLngfrom != null) {
                     textViewfrom=(TextView) findViewById(R.id.TvLatFrom);
                    textViewfrom.setText(latLngfrom.latitude + " " + latLngfrom.longitude);
                    Log.d("Lat Lng : ", " " + latLngfrom.latitude + " " + latLngfrom.longitude);
                    final double latfrom=latLngfrom.latitude;
                    Address from = getAddressFromLatLng(latLngfrom);
                    if (from != null) {
                        Log.d("Address : ", "" + from.toString());
                        Log.d("Address Line : ", "" + from.getAddressLine(0));
                        Log.d("Phone : ", "" + from.getPhone());
                        Log.d("Pin Code : ", "" + from.getPostalCode());
                        Log.d("Feature : ", "" + from.getFeatureName());
                        Log.d("More : ", "" + from.getLocality());
                    } else {
                        Log.d("Adddress", "Address Not Found");
                    }
                } else {
                    Log.d("Lat Lng", "Lat Lng Not Found");
                }

            }
        });
        to.setAdapter(new PlaceAutoSuggestAdapter(MainActivity.this,android.R.layout.simple_list_item_1));

        to.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Log.d("Address : ",to.getText().toString());
                LatLng latLngto=getLatLngFromAddress(to.getText().toString());
                if(latLngto!=null) {
                     textViewto=(TextView) findViewById(R.id.TvLatTo);
                    textViewto.setText(latLngto.latitude + " " + latLngto.longitude);
                    Log.d("Lat Lng : ", " " + latLngto.latitude + " " + latLngto.longitude);
                    Address to=getAddressFromLatLng(latLngto);
                    if(to!=null) {

                        Log.d("Address : ", "" + to.toString());
                        Log.d("Address Line : ",""+to.getAddressLine(0));
                        Log.d("Phone : ",""+to.getPhone());
                        Log.d("Pin Code : ",""+to.getPostalCode());
                        Log.d("Feature : ",""+to.getFeatureName());
                        Log.d("More : ",""+to.getLocality());
                    }
                    else {
                        Log.d("Adddress","Address Not Found");
                    }
                }
                else {
                    Log.d("Lat Lng","Lat Lng Not Found");
                }

            }
        });



    }

    private boolean PlayServicesUpdate() {


            GoogleApiAvailability googleApiAvailability = GoogleApiAvailability.getInstance();

            int resultCode = googleApiAvailability.isGooglePlayServicesAvailable(this);

            if (resultCode != ConnectionResult.SUCCESS) {
                if (googleApiAvailability.isUserResolvableError(resultCode)) {

                    if (errorDialog == null) {
                        errorDialog = googleApiAvailability.getErrorDialog(this, resultCode, 2404);
                        errorDialog.setCancelable(false);
                    }

                    if (!errorDialog.isShowing())
                        errorDialog.show();

                }
            }

            return resultCode == ConnectionResult.SUCCESS;


    }

    private LatLng getLatLngFromAddress(String address){

        Geocoder geocoder=new Geocoder(MainActivity.this);
        List<Address> addressList;

        try {
            addressList = geocoder.getFromLocationName(address, 1);
            if(addressList!=null){
                Address singleaddress=addressList.get(0);
                LatLng latLng=new LatLng(singleaddress.getLatitude(),singleaddress.getLongitude());
                return latLng;
            }
            else{
                return null;
            }
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    private Address getAddressFromLatLng(LatLng latLng){
        Geocoder geocoder=new Geocoder(MainActivity.this);
        List<Address> addresses;
        try {
            addresses = geocoder.getFromLocation(latLng.latitude, latLng.longitude, 5);
            if(addresses!=null){
                Address address=addresses.get(0);
                return address;
            }
            else{
                return null;
            }
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    public void CalDistance(View view) {
        TextView distanceTextView=findViewById(R.id.distance);
        from = findViewById(R.id.from);
        to = findViewById(R.id.to);
            try {
                // POST Request
                StringBuilder sb = new StringBuilder("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=");
                sb.append(from.getText());
                sb.append("&destinations=");
                sb.append(to.getText());
                sb.append("&key=AIzaSyBuUhnC2p8pB65r6S9oHyXQdKY3VvUUqCI");

                URL url = new URL(sb.toString());


                HttpURLConnection conn = (HttpURLConnection)url.openConnection();
                conn.setRequestMethod("GET");
                conn.connect();
                int responsecode = conn.getResponseCode();
                if(responsecode==200){
                    Log.d("ResponseCode", responsecode+"");
//                    InputStreamReader inputStreamReader=new InputStreamReader(conn.getInputStream());
                    Scanner sc = new Scanner(conn.getInputStream());
                    String inline=null;
                    while(sc.hasNext()){

                         inline+=sc.nextLine();

                    }
                    System.out.println("\nJSON data in string format");
                    Log.d("Results",inline);
                    Toast.makeText(this, inline+"api", Toast.LENGTH_SHORT).show();
                }
                else{
                    distanceTextView.setText("not available");
                    Log.d("TAG", "CalDistance: ");
                    throw new RuntimeException("HttpResponseCode:" +responsecode);

                }


                distanceTextView.setText("KM");

            } catch (Exception ex) {
                ex.printStackTrace();
            }




        }
}
