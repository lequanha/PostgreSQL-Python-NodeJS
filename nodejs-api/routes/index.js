var express = require('express');
var router = express.Router();

var db = require('../queries');

router.get('/api/data', db.getAllData);
router.get('/api/clusters', db.getAllClusters);
router.get('/api/sensors', db.getAllSensors);
router.get('/api/data/:id', db.getSingleData);
router.post('/api/data/:clusterid/:sensorid/:data', db.createData);
router.get('/api/cluster/:mean/:deviation', db.getClusterID);
router.post('/api/cluster/:mean/:deviation', db.createCluster);
router.delete('/api/cluster/:mean/:deviation', db.removeCluster);
router.post('/api/sensor/:id/:name', db.createSensor);
router.delete('/api/sensor/:name', db.removeSensor);

module.exports = router;

